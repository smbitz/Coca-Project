package cocahappymachine.util {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class Config {

		private static const CONFIG_URL:String = "config.xml";
		
		private static var instance:Config;
		
		private var topicPanelTextNormal:String;
		private var topicPanelTextTopicSelected:String;
		private var topicPanelTextSubtopicSelected:String;
		private var loadComplete:Boolean;
		
		private var valuePair:Array;
		private var callBackFunction:Array;
		
		public function Config() {
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
			valuePair = new Array();
			callBackFunction = new Array();
			loadComplete = false;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onConfigLoad );
			urlLoader.load(new URLRequest(CONFIG_URL));
		}
		
		public function addCallBack(f:Function){
			callBackFunction.push(f);
		}
		
		public static function getInstance():Config{
			if(instance == null){
				instance = new Config();
			}
			return instance;
		}
		
		public function onConfigLoad(event:Event){
			var xml:XML = new XML(event.target.data);
			var stringElements:XMLList = xml.elements("string");
			for each (var s:XML in stringElements) {
				setString(s);
			}
			loadComplete = true;
			for each(var f:Function in callBackFunction){
				f();
			}
		}
		
		public function isLoadComplete(){
			return loadComplete;
		}
		
		private function setString(xml:XML){
			var name:String;
			var value:String;
			for each(var attribute:XML in xml.attributes()){
				if(attribute.name() == "name"){
					name = attribute;
				} else if(attribute.name() == "value"){
					value = attribute;
				}				
			}
			var data:DataPair = new DataPair();
			data.key = name;
			data.value = value;
			valuePair.push(data);
		}
		
		public function getData(key:String):String{
			for each(var data:DataPair in valuePair){
				if(data.key == key){
					return data.value;
				}
			}
			throw new Error("Data not found in Config");
		}

	}

}