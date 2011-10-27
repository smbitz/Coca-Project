package cocahappymachine.data {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;
	
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
		public static const QTY_TO_BUILD:int = 1;
		
		public function Player(facebookId:String) {
			this.facebookId = facebookId;
			isLoad = false;
			tile = new Array();
			backpack = new Array();
			bManager = BuildingManager.getInstance();
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
					var newItem:Backpack = new Backpack();
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
				}else if(this.money > moneyItem*QTY_TO_BUILD){
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
			var arrayYieldItem:Array = t.getBuilding().getYieldItem();
		}
		
		//---- Purchase that tile ----//
		public function purchase(t:Tile){
			//calculate
			t.setIsOccupy(true);
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
			var buildingType:String = targetTile.getBuilding().getBuildingType();
			
			if(buildingType=="vege"){
				var moneyVegeSupply:int = ItemManager.getInstance().howMoney("160"); //BUG
				
				//BUG
				if(isItemEnough("160", 1)){
					var searchVegeSupply:int = this.searchBackpackItem("160"); //BUG
					var currentVegeQty:int = this.backpack[searchVegeSupply].getItemQty();
					
					this.backpack[searchVegeSupply].setItemQty(currentVegeQty-1);
//					targetTile.setSupply(14400000);
					return true;
				}else if(this.money > moneyVegeSupply){
					this.money -= moneyVegeSupply;
//					targetTile.setSupply(14400000);
					return true;
				}
			}else if(buildingType=="meat"){
				var moneyMeatSupply:int = ItemManager.getInstance().howMoney("170"); //BUG
				
				//BUG
				if(isItemEnough("170", 1)){
					var searchMeatSupply:int = this.searchBackpackItem("170"); //BUG
					var currentMeatQty:int = this.backpack[searchMeatSupply].getItemQty();
					
					this.backpack[searchMeatSupply].setItemQty(currentMeatQty-1);
//					targetTile.setSupply(14400000);
					return true;
				}else if(this.money > moneyMeatSupply){
					this.money -= moneyVegeSupply;
//					targetTile.setSupply(14400000);
					return true;
				}
			}else if(buildingType=="sea"){
				var moneySeaSupply:int = ItemManager.getInstance().howMoney("180");	//BUG
				
				//BUG
				if(isItemEnough("180", 1)){
					var searchSeaSupply:int = this.searchBackpackItem("180"); //BUG
					var currentSeaQty:int = this.backpack[searchSeaSupply].getItemQty();
					
					this.backpack[searchSeaSupply].setItemQty(currentSeaQty-1);
//					targetTile.setSupply(14400000);
					return true;
				}else if(this.money > moneySeaSupply){
					this.money -= moneyVegeSupply;
//					targetTile.setSupply(14400000);
					return true;
				}
			}
			return false;
		}
		
		//---- add extraItem to targetTile
		public function extraItem(targetTile:Tile, extraItem:Item):Boolean{
			//reduce item quantity (extra item can't purchase)
			//building paramter change to effect extra item
			var buildingType:String = targetTile.getBuilding().getBuildingType();
			
			if(buildingType=="vege"){
				//BUG
				if(extraItem.getId()=="7010"||extraItem.getId()=="7020"){
					if(isItemEnough(extraItem.getId(), 1)){
						var searchVegeExtra:int = this.searchBackpackItem(extraItem.getId());
						var currentVegeExtraQty:int = this.backpack[searchVegeExtra].getItemQty();
						
						this.backpack[searchVegeExtra].setItemQty(currentVegeExtraQty-1);
						targetTile.setExtraId(extraItem.getId());
						return true;
					}
				}
			}else if(buildingType=="meat"){
				//BUG
				if(extraItem.getId()=="7030"||extraItem.getId()=="7040"){
					if(isItemEnough(extraItem.getId(), 1)){
						var searchMeatExtra:int = this.searchBackpackItem(extraItem.getId());
						var currentMeatExtraQty:int = this.backpack[searchMeatExtra].getItemQty();
						
						this.backpack[searchMeatExtra].setItemQty(currentMeatExtraQty-1);
						targetTile.setExtraId(extraItem.getId());
						return true;
					}
				}
			}else if(buildingType=="sea"){
				//BUG
				if(extraItem.getId()=="7050"||extraItem.getId()=="7060"){
					if(isItemEnough(extraItem.getId(), 1)){
						var searchSeaExtra:int = this.searchBackpackItem(extraItem.getId());
						var currentSeaExtraQty:int = this.backpack[searchSeaExtra].getItemQty();
						
						this.backpack[searchSeaExtra].setItemQty(currentSeaExtraQty-1);
						targetTile.setExtraId(extraItem.getId());
						return true;
					}
				}
			}
			return false;
		}
	}
}