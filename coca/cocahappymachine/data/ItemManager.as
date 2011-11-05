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
			var dataXml:XML = new XML(event.target.data);
			
			//for each building node
			for each(var item_root:XML in dataXml.item){
				//create new building
				var newItem:Item = new Item();
				
				//set data from xml
				newItem.setDataFromXmlNode(item_root);
				
				//add building to array
				item.push(newItem);
			}
			isLoad = true;
			loadCallback();
		}
		
		public function getItem():Array{
			return item;
		}
		
		//---- get array of item which have the same type as requested ----//
		public function getItemByType(type:String):Array{
			var itemArrayByType:Array = new Array();
			var allItemArray:Array = this.item;
			
			for each(var allItem:Item in allItemArray){
				if(allItem.getItemType()==type){
					itemArrayByType.push(allItem);
				}
			}
			
			return itemArrayByType;
		}
		
		public function howMoney(id:String):int{
			for each(var matchItemId:Item in item){
				if(matchItemId.getId()==id){
					return matchItemId.getPrice();
				}
			}
			return 0;
		}
		
		public function getMatchItem(id:String):Item{
			for each(var matchItemId:Item in item){
				if(matchItemId.getId()==id){
					return matchItemId;
				}
			}
			return null;
		}
		
		private function onIOError(event:IOErrorEvent){
			trace("item IO Error");
			load(loadCallback);
		}

	}
	
}
