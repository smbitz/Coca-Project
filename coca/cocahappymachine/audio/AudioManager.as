package cocahappymachine.audio {
	import cocahappymachine.util.Config;
	import flash.media.Sound;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	
	public class AudioManager {

		private static var instance:AudioManager = null;
		private var isLoad:Boolean;
		private var loadCallback:Function;
		private var audioPair:Array;		//Array of AudioPair
		private var loadCount:int;
		private var bgChannel:SoundChannel;
		
		public function AudioManager() {
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
			isLoad = false;
			loadCount = 0;
			audioPair = new Array();
		}
		
		public static function getInstance() {
			if(instance == null){
				instance = new AudioManager();
			}
			return instance;
		}
		
		public function isLoadComplete():Boolean {
			return isLoad;
		}
		
		public function load(callback:Function){
			loadCallback = callback;
			var listStr:String = Config.getInstance().getData("AUDIO_LIST");
			var listArray:Array = listStr.split(",");
			for each(var item:String in listArray){
				var pair:AudioPair = new AudioPair();
				pair.key = item;
				pair.audio = new Sound();
				pair.audio.load(new URLRequest(Config.getInstance().getData(pair.key)));
				pair.audio.addEventListener(Event.COMPLETE, onAudioLoad);
				audioPair.push(pair);
			}
			onAudioLoadComplete();
		}
		
		public function onAudioLoadComplete(){
			isLoad = true;
			loadCallback();
		}
		
		public function onAudioLoad(event:Event){
			loadCount++;
			if(loadCount == audioPair.length){
				onAudioLoadComplete();
			}
		}
		
		public function playBG(key:String){
			if(bgChannel != null){
				bgChannel.stop();
			}
			for each(var pair:AudioPair in audioPair){
				if(pair.key == key){
					bgChannel = pair.audio.play(0, 9999);
				}
			}
		}
		
		public function playEffect(key:String){
			for each(var pair:AudioPair in audioPair){
				if(pair.key == key){
					pair.audio.play();
				}
			}
		}
	}
}