package cocahappymachine.data {

	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;
	import flash.errors.IOError;
	
	//load item data from server for using in any part of system.
	//ItemManager implement singleton pattern, so don't instantiate it.
	public class ItemManager {

		private static var instance:ItemManager = null;
		
		private var item:Array;		// item is an array of Item
		private var isLoad:Boolean;
		private var loadCallback:Function;
		
		public function ItemManager() {
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
			isLoad = false;
			item = new Array();
		}
		
		public static function getInstance():ItemManager{
			if(instance == null){
				instance = new ItemManager();
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
			var url:String = Config.getInstance().getData("ITEM_URL");
			urlLoader.load(new URLRequest(url));
		}
		
		private function onXmlComplete(event:Event){
			//get list of building node
			//for each building node
				//create new building
				//set data from xml
				//add building to array
			isLoad = true;
			loadCallback();
		}
		
		private function onIOError(event:IOErrorEvent){
			trace("item IO Error");
			load(loadCallback);
		}

	}
	
}
