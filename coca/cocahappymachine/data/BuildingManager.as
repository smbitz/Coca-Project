﻿package cocahappymachine.data {

	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;

	//load building data from server for using in any part of system.
	//BuildingManager implement singleton pattern, so don't instantiate it.
	public class BuildingManager {

		private static var instance:BuildingManager = null;

		private var building:Array;		// building is an array of Building
		private var isLoad:Boolean;
		private var loadCallback:Function;
				
		public function BuildingManager() {
			// constructor code
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
			isLoad = false;
			building = new Array();
		}
		
		public static function getInstance() {
			if(instance == null){
				instance = new BuildingManager();
			}
			return instance;
		}

		public function isLoadComplete():Boolean {
			return isLoad;
		}

		public function load(callback:Function){
			loadCallback = callback;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onXmlComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("BUILDING_URL");
			urlLoader.load(new URLRequest(url));
		}
		
		private function onXmlComplete(event:Event){
			//get list of building node
			var dataXml:XML = new XML(event.target.data);
			
			//for each building node
			for each(var building_root:XML in dataXml.building){
				//create new building
				var newBuilding:Building = new Building();
				
				//set data from xml
				newBuilding.setDataFromXmlNode(building_root);
				
				//add building to array
				building.push(newBuilding);
			}
			isLoad = true;
			loadCallback();
		}
		
		public function getBuilding():Array{
			return building;
		}
		
		private function onIOError(event:IOErrorEvent){
			trace("building IO Error");
			load(loadCallback);
		}

	}
	
}
