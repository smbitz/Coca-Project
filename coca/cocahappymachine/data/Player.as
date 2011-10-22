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
	}
}