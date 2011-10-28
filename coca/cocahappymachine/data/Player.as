package cocahappymachine.data {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;
	import cocahappymachine.util.Debug;
	
	public class Player {

		private var facebookId:String;
		private var exp:int;
		private var money:int;
		private var isNew:Boolean;
		private var tile:Array;		//array of Tile
		private var backpack:Array;	//array of BackpackItem
		
		private var isLoad:Boolean;
		private var loadCallback:Function;
		
		private var bManager:BuildingManager;
		
		public static const TILE_MAX_X:int = 8;
		public static const TILE_MAX_Y:int = 8;
		private static const QTY_TO_BUILD:int = 1;
		private static const QTY_USE_SUPPLY:int = 1;
		private static const QTY_USE_EXTRA:int = 1;
		
		public function Player(facebookId:String) {
			this.facebookId = facebookId;
			isLoad = false;
			tile = new Array();
			backpack = new Array();
			bManager = BuildingManager.getInstance()
		}
		
		public function isLoadComplete():Boolean {
			return isLoad;
		}
		
		public function load(callback:Function){
			//load player data from server base on facebookId
			loadCallback = callback;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onXmlComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("PLAYER_URL");
			urlLoader.load(new URLRequest(url));
		}
	
		private function onXmlComplete(event:Event){
			//get list of building node
			var dataXml:XML = new XML(event.target.data);
			
			//for each building node
			for each(var playerData:XML in dataXml){
				for each(var playerDataAttributes:XML in playerData.attributes()){
					if (playerDataAttributes.name()=="facebook_id") {
						facebookId = playerDataAttributes;
					}else if (playerDataAttributes.name()=="exp") {
						exp = int(playerDataAttributes);
					}else if (playerDataAttributes.name()=="money") {
						money = int(playerDataAttributes);
					}else if (playerDataAttributes.name()=="is_new") {
						isNew = Boolean(playerDataAttributes);
					}
				}
				
				//tile
				for each(var landAttributes:XML in playerData.land.tile){
					var newTile:Tile = new Tile();
					newTile.setDataFromXmlNode(landAttributes);
					tile.push(newTile);
				}
				
				//backpack
				for each(var backpackAttributes:XML in playerData.backpack.item){
					var newItem:ItemQuantityPair = new ItemQuantityPair();
					newItem.setDataFromXmlNode(backpackAttributes);
					backpack.push(newItem);
				}
			}
			isLoad = true;
			loadCallback();
		}
		
		public function getTile():Array{
			return tile;
		}
		
		public function getTileByLocate(getTileX, getTileY):Tile{
			var arrayIndex:int = getTileX + (getTileY * TILE_MAX_X);
			return tile[arrayIndex];
		}
		
		public function getBackpack():Array{
			return backpack;
		}
		
		public function getMoney():int{
			return money;
		}
		private function onIOError(event:IOErrorEvent){
			trace("player IO Error");
			load(loadCallback);
		}
		
		public function isNewGame():Boolean{
			return isNew;
		}
		
		public function update(elapse:int){
			//update all building progress with elapse
			for(var a:int = 0; a<tile.length; a++){
				tile[a].update(elapse);
			}
			
			/*//test
			var arrayBuilding:Array = BuildingManager.getInstance().getBuilding();
			//trace(arrayBuilding.length);
			this.build(2, 2, BuildingManager.getInstance().getBuilding()[0]); //tile[18]
			//this.supplyItem(tile[18]);
			//trace(tile[18].length);
			this.supplyItem(tile[18]);
			//this.extraItem(tile[18], BuildingManager.getInstance().getBuilding()[0].getExtra()[0].getItem());*/
		}
		
		public function build(locationX:int, locationY:int, building:Building){
			//check for all build condition (1) land type (2) required items
			var currentTile:Tile = getTileByLocate(locationX, locationY);
			var moneyItem:int = ItemManager.getInstance().howMoney(building.getBuildItemId());

			if(currentTile.isAllowToBuild(building)){
				if(this.isItemEnough(building.getBuildItemId(), QTY_TO_BUILD)){
					for(var c:int; c < backpack.length; c++){
						if(backpack[c].getItemId()==building.getBuildItemId()){
							backpack[c].setItemQty(backpack[c].getItemQty()-QTY_TO_BUILD);
						}
					}
					currentTile.build(building);
				}else if(this.money >= moneyItem*QTY_TO_BUILD){
					this.money -= (moneyItem*QTY_TO_BUILD);
					currentTile.build(building);
				}else {
					//don't allow to build
				}
			} else {
				//don't allow to build	
			}
		}
		
		//---- Search item in player's backpack ----//
		private function searchBackpackItem(searchItemId:String):int{
			for(var c:int; c < this.backpack.length; c++){
				if(this.backpack[c].getItemId()==searchItemId){
					return c;
				}
			}
			return -1;
		}
		
		//---- Harvest completed building on that tile ----//
		public function harvest(t:Tile){
			//Harvest Yield Item
			var getYieldItem:Array = t.getBuilding().generateYieldItem();
			
			for each(var arrayGetYieldItem in getYieldItem){
				var yieldItemId:String = arrayGetYieldItem.getItem().getId();
				var itemPositionBackpack:int = searchBackpackItem(yieldItemId);
				
				if(itemPositionBackpack>=0){
					var currentBackpackQty:int = this.backpack[itemPositionBackpack].getItemQty();
					var yieldItemQty:int = arrayGetYieldItem.getItem().getItemQty();
					
					this.backpack[itemPositionBackpack].setItemQty(currentBackpackQty+yieldItemQty);
				}else{
					var b:ItemQuantityPair = new ItemQuantityPair();
					b.setItemQty(arrayGetYieldItem.getItem().getItemQty());
					b.setItem(arrayGetYieldItem.getItem());
					b.setItemId(arrayGetYieldItem.getItem().getId())
					this.backpack.push();
				}
			}
			
			//Harvest Money
			var getYieldMoney:int = t.getBuilding().generateYieldMoney();
			
			this.money += getYieldMoney;
			
			//Clear Tile
			t.setBuildingId("NULL");
			t.setProgress(0);
			t.setSupply(0);
			t.setExtraId("NULL");
			t.setBuilding(null);
			t.setRottenPeriod(0);
		}
		
		//---- Purchase that tile ----//
		public function purchase(t:Tile){
			//calculate
			for(var i:int = 0; i < tile.length; i++){
				if(tile[i] == t){
					tile[i].setIsOccupy(true);
					tile[i + 1].setIsOccupy(true);
					tile[i + TILE_MAX_X].setIsOccupy(true);
					tile[i + TILE_MAX_X + 1].setIsOccupy(true);
				}
			}
			
			//money
			var totalPlayerFarm:int = 0;
			for each(var arrayTile:Array in tile){
				if(arrayTile.getIsOccupy()==true){
					totalPlayerFarm++;
				}
			}
			
			var moneyToPurchase = 500 + (500 * (totalPlayerFarm ^ 2) );
			this.money -= moneyToPurchase;
		}
		
		//---- Calculate and return money required for purchase tile ----//
		public function getMoneyRequiredForPurchaseTile():int{
			return 0;
		}
		
		//---- Calculate and return level required for purchase tile ----//
		public function getLevelRequiredForPurchaseTile():int{
			return 0;
		}
		
		public function isItemEnough(itemId:String, quantity:int):Boolean{
			//check from backpack for enough item in that itemId
			for(var b:int; b < backpack.length; b++){
				if(backpack[b].getItemId()==itemId&&backpack[b].getItemQty()>=quantity){
					return true
				}
			}
			return false;
		}
		
		public function exchange(itemId:String){
			//send request to server asking for exchange item to coupon
		}
		
		//---- Callback function for exchange() ----//
		public function onExchangeReply(){
			//if success
				//reduce amount of item using for exchange
				//add coupon item to player backpack
			//else
				//respond to player that exchange was rejected
		}
		
		public function couponCodeView(itemId:String){
			//send request to server asking for the code of coupon
		}
		
		//---- Callback function for couponCodeView() ----//
		public function onCouponCodeViewReply(){
			
		}
		
		public function specialCodeInput(code:String){
			//send request to server asking for the verify code
		}
		
		//---- Callback function for specialCodeInput() ----//
		public function onSpecialCodeInputReply(){
			
		}
		
		//---- Supply item to targetTile
		public function supplyItem(targetTile:Tile):Boolean{
			//reduce item quantity or reduce money if player don't have that item
			//building parameter change to effect supply item
			var supplyItemId:String = targetTile.getBuilding().getSupplyId();
			var moneySupply:int = ItemManager.getInstance().howMoney(supplyItemId);
				
			if(isItemEnough(supplyItemId, QTY_USE_SUPPLY)){
				var searchSupply:int = this.searchBackpackItem(supplyItemId);
				var currentQty:int = this.backpack[searchSupply].getItemQty();
				
				if(searchSupply>=0){
					this.backpack[searchSupply].setItemQty(currentQty-1);
					targetTile.setSupply(targetTile.getBuilding().getBuildPeriod());
					return true;
				}
			}else if(this.money > moneySupply){
				this.money -= moneySupply;
					targetTile.setSupply(targetTile.getBuilding().getBuildPeriod());
				return true;
			}
			return false;
		}
		
		//---- add extraItem to targetTile
		public function extraItem(targetTile:Tile, extraItem:Item):Boolean{
			//reduce item quantity (extra item can't purchase)
			//building paramter change to effect extra item
			var extraItemId1:String = targetTile.getBuilding().getExtraItem1().getId();
			var extraItemId2:String = targetTile.getBuilding().getExtraItem2().getId();
			
			if(extraItem.getId()==extraItemId1||extraItem.getId()==extraItemId2){
				if(isItemEnough(extraItem.getId(), QTY_USE_EXTRA)){
					var searchExtra:int = this.searchBackpackItem(extraItem.getId());
					var currentExtraQty:int = this.backpack[searchExtra].getItemQty();
					
					if(searchExtra>=0){
						this.backpack[searchExtra].setItemQty(currentExtraQty-1);
						targetTile.setExtraId(extraItem.getId());
						return true;
					}
				}
			}
			return false;
		}
	}
}