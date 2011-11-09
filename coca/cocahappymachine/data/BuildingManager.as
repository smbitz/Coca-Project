package cocahappymachine.data {

	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;
	import cocahappymachine.util.Debug;
	import flash.events.SecurityErrorEvent;
	
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
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			var url:String = Config.getInstance().getData("BUILDING_URL");
			urlLoader.load(new URLRequest(url));
		}
		
		public function onXmlComplete(event:Event){
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
			Debug.getInstance().debug("xmlLoad Complete");
		}
		
		public function getBuilding():Array{
			return building;
		}
		
		public function getMatchBuilding(id:String):Building{
			for each(var matchBuildingId:Building in building){
				if(matchBuildingId.getId()==id){
					return matchBuildingId;
				}
			}
			return null;
		}
		
		public function onIOError(event:IOErrorEvent){
			trace("building IO Error");
			load(loadCallback);
			Debug.getInstance().debug("IOError Event");
		}
		
		public function getBuildingForLandType(landType:String):Array {
			var arrayBuildingFromLand:Array = new Array();
			//if land type is "land" then
			if(landType=="land"){
				//get all building with type "vege" or "meat"
				for each(var arrayLandBuilding:Building in building){
					if(arrayLandBuilding.getBuildingType()=="vege"||arrayLandBuilding.getBuildingType()=="meat"){
						arrayBuildingFromLand.push(arrayLandBuilding);
					}
				}
			}else if(landType=="sea"){
			// else if land type is "sea" then
				//get all building with type "sea"
				for each(var arraySeaBuilding:Building in building){
					if(arraySeaBuilding.getBuildingType()=="sea"){
						arrayBuildingFromLand.push(arraySeaBuilding);
					}
				}
			}else{
			// else
				//throw error
				throw new Error("Unexpected from getBuildingForLandType in BuildingManager.as");
			}
			return arrayBuildingFromLand;
		}

		public function onSecurityError(event:SecurityError){
			Debug.getInstance().debug("SecurityError Event");
		}
		
		//---- find the building which given item used to build it ----//
		//---- return building or null if item isn't use to build ----//
		public function getBuildingByBuildItem(item:Item):Building{
			for each(var eachBuilding:Building in this.building){
				if(eachBuilding.getBuildItemId()==item.getId()){
					return eachBuilding;
				}
			}
			
			return null;
		}
	}
	
}
