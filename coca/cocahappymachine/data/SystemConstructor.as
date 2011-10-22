package cocahappymachine.data {
	
	import cocahappymachine.data.ItemManager;
	import cocahappymachine.data.BuildingManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.util.Config;
	import cocahappymachine.util.Debug;

	//Instanctiate all necessary data using in application, then callback to one function
	public class SystemConstructor {
		
		private static var instance:SystemConstructor = null;
		
		private var facebookId:String;

		private var currentPlayer:Player;
		private var isLoad:Boolean = false;
		private var constructCallback:Function;
		private var iManager:ItemManager;
		private var bManager:BuildingManager;

		public function SystemConstructor() {
			facebookId = "1001";
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
		private function initData() {
			//retrive all information from HTML
			iManager = ItemManager.getInstance();
			bManager = BuildingManager.getInstance();
			iManager.load(onItemComplete);
			bManager.load(onBuildingComplete);
			currentPlayer = new Player(facebookId);
			currentPlayer.load(onPlayerComplete);
		
		}
		private function onConfigComplete(){
			initData();
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
		
		private function isAllLoadComplete():Boolean{
			if(iManager.isLoadComplete() && bManager.isLoadComplete() && currentPlayer.isLoadComplete()){
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
