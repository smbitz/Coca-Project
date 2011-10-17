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
		
		public function Player(facebookId:String) {
			this.facebookId = facebookId;
			isLoad = false;
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
			//for each building node
				//create new building
				//set data from xml
				//add building to array
			isLoad = true;
			loadCallback();
		}
		
		private function onIOError(event:IOErrorEvent){
			trace("player IO Error");
			load(loadCallback);
		}

	}
	
}
