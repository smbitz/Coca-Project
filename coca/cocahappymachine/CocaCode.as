package cocahappymachine {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.SystemConstructor;
	import cocahappymachine.data.Player;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.media.Camera;
	import flash.utils.getDefinitionByName;
	
	
	public class CocaCode extends MovieClip {
		
		public function CocaCode() {
			SystemConstructor.getInstance().construct(onSystemComplete);
			
			//---- Test Load External Symbol ----
			var path:URLRequest = new URLRequest("Resources.swf");
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,runtimeAssetsLoadComplete);
			loader.load(path,context);
			//-----------------------------------

		}		

		public function onSystemComplete(player:Player){
			trace("all load complete");
			//start game
		}
		
		//Callback function for Load External Symbol testing
		public function runtimeAssetsLoadComplete(event:Event){
			trace("Asset load Complete");
			var c:Class = getDefinitionByName("Resources.TestSymbol") as Class;
			var mc:MovieClip = new c();
			this.addChild(mc);
		}
	}
	
}
