﻿package cocahappymachine.data {
	
	import cocahappymachine.data.ItemManager;
	import cocahappymachine.data.BuildingManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.util.Config;

	//Instanctiate all necessary data using in application, then callback to one function
	public class SystemConstructor {
		
		private static var instance:SystemConstructor = null;

		private var currentPlayer:Player;
		private var isLoad:Boolean = false;
		private var constructCallback:Function;
		private var iManager:ItemManager;
		private var bManager:BuildingManager;

		public function SystemConstructor() {
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

		//construct data by (1)load config (2)load item/building/player
		public function construct(callback:Function){
			constructCallback = callback;
			Config.getInstance().addCallBack(onConfigComplete);
		}
		private function initData() {
			//retrive all information from HTML
			var facebookId:String = "1001";
			iManager = ItemManager.getInstance();
			bManager = BuildingManager.getInstance();
			iManager.load(onItemComplete);
			bManager.load(onBuildingComplete);
			currentPlayer = new Player(facebookId);
			currentPlayer.load(onPlayerComplete);
		
		}
		private function onConfigComplete(){
			trace("config complete");
			initData();
		}
		
		private function onItemComplete(){
			trace("item complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function onBuildingComplete(){
			trace("building complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function onPlayerComplete(){
			trace("player complete");
			if( isAllLoadComplete()){
				onAllLoadComplete();
			}
		}
		
		private function isAllLoadComplete():Boolean{
			if(iManager.isLoadComplete() && bManager.isLoadComplete() && currentPlayer.isLoadComplete()){
				return true;
			}
			return false;
		}
		
		private function onAllLoadComplete(){
			//manage data
			constructCallback(currentPlayer);
		}
	}
	
}
