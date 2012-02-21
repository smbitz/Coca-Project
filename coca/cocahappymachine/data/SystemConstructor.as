package cocahappymachine.data {
	
	import cocahappymachine.data.ItemManager;
	import cocahappymachine.data.BuildingManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.util.Config;
	import cocahappymachine.util.Debug;
	import cocahappymachine.audio.AudioManager;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.events.EventDispatcher;
	import cocahappymachine.ui.LoadEvent;


	//Instanctiate all necessary data using in application, then callback to one function
	public class SystemConstructor extends EventDispatcher {
		
		public static const LOAD_PROGRESS:String = "LOAD_PROGRESS";
		private static var instance:SystemConstructor = null;
		
		private var facebookId:String;
		private var playerName:String;
		private var playerSex:String;

		private var currentPlayer:Player;
		private var isLoad:Boolean = false;
		private var isAsset:Boolean = false;
		private var constructCallback:Function;
		private var iManager:ItemManager;
		private var bManager:BuildingManager;
		private var aManager:AudioManager;

		public function SystemConstructor() {
			facebookId = "100111";
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
		}
		
		public static function getInstance(){
			if(instance == null){
				instance = new SystemConstructor();
			}
			return instance
		}
		
		public function getCurrentPlayer():Player{
			return currentPlayer;
		}

		//construct data by (1)load config (2)load item/building/player
		public function construct(callback:Function){
			constructCallback = callback;
			Config.getInstance().addCallBack(onConfigComplete);
		}
		
		public function setFacebookId(id:String){
			facebookId = id;
		}
		
		public function setPlayerName(name:String){
			playerName = name;
		}
		
		public function setPlayerSex(sex:String){
			playerSex = sex;
		}
		
		private function initData() {
			//retrive all information from HTML
			aManager = AudioManager.getInstance();
			aManager.load(onAudioComplete);
			iManager = ItemManager.getInstance();
			bManager = BuildingManager.getInstance();
			iManager.load(onItemComplete);
			bManager.load(onBuildingComplete);
			currentPlayer = new Player(facebookId,playerName,playerSex);
			currentPlayer.load(onPlayerComplete);
		
			//---- Load External SWF ----//
			var path:URLRequest = new URLRequest("Resources.swf");
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoadComplete);
			loader.load(path,context);
		}
		
		public function onSWFLoadComplete(event:Event){
			Debug.getInstance().debug("Asset load Complete");
			isAsset = true;
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
	
		private function onConfigComplete(){
			initData();
		}
		
		private function onAudioComplete(){
			Debug.getInstance().debug("Audio complete");

		}
		
		private function onItemComplete(){
			Debug.getInstance().debug("item complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function onBuildingComplete(){
			Debug.getInstance().debug("building complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function onPlayerComplete(){
			Debug.getInstance().debug("player complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function getPercentComplete():int {
			var count:int = 0;
			if(iManager.isLoadComplete()){
				count++;
			}
			if(bManager.isLoadComplete()){
				count++;
			}
			if(currentPlayer.isLoadComplete()){
				count++;
			}
			if(aManager.isLoadComplete()){
				count++;
			}
			if(isAsset){
				count++;
			}
			return int(count * 100 / 4);			
		}
		private function isAllLoadComplete():Boolean{
			this.dispatchEvent(new LoadEvent(LOAD_PROGRESS, getPercentComplete()));
			if(iManager.isLoadComplete() && bManager.isLoadComplete() && 
			   currentPlayer.isLoadComplete() && aManager.isLoadComplete() && isAsset){
				manageData();
				return true;
			}
			return false;
		}
		
		private function manageData(){
			//Set Item Building Data
			var arrayOfBuilding = bManager.getBuilding();
			
			//for all building
			for each(var buildingFeatch:Building in arrayOfBuilding){
				buildingFeatch.setBuildItem(iManager.getMatchItem(buildingFeatch.getBuildItemId()));
				buildingFeatch.setSupplyItem(iManager.getMatchItem(buildingFeatch.getSupplyId()));
				
				var arrayBuildingExtra = buildingFeatch.getExtra();
				for(var i:int = 0; i < arrayBuildingExtra.length; i++){
					arrayBuildingExtra[i].setItem(iManager.getMatchItem(arrayBuildingExtra[i].getId()));
				}
				
				var arrayBuildingYield = buildingFeatch.getYieldItem();
				for(var j:int = 0; j < arrayBuildingYield.length; j++){
					//Money
					if(arrayBuildingYield[j].getId()!="money"){
						arrayBuildingYield[j].setItem(iManager.getMatchItem(arrayBuildingYield[j].getId()));
					}
				}
			}
			
			//Set Item Data
			var arrayOfItem = iManager.getItem();
			
			//For all item
			//Set exchange item
			for each(var itemFeatch:Item in arrayOfItem){
				var arrayItemExchange = itemFeatch.getExchangeItem();
				for(var a:int = 0; a < arrayItemExchange.length; a++){
					arrayItemExchange[a].setItem(iManager.getMatchItem(arrayItemExchange[a].getId()));
				}
			}
			
			//Set Player Data
			//Set Tile
			var arrayPlayerTile = currentPlayer.getTile();
			for(var z:int = 0 ; z < arrayPlayerTile.length; z++){
				if(arrayPlayerTile[z].getBuildingId() != null){
					arrayPlayerTile[z].setBuilding(bManager.getMatchBuilding(arrayPlayerTile[z].getBuildingId()));
				}
			}
			
			//Set Backpack
			var arrayPlayerBackpack = currentPlayer.getBackpack();
			for(var q:int = 0 ; q < arrayPlayerBackpack.length; q++){
				arrayPlayerBackpack[q].setItem(iManager.getMatchItem(arrayPlayerBackpack[q].getItemId()));
			}
		}
		
		private function onAllLoadComplete(){
			//manage data
			constructCallback(currentPlayer);
		}
	}
	
}
