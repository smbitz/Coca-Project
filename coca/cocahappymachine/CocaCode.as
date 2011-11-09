package cocahappymachine {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.SystemConstructor;
	import cocahappymachine.data.Player;
	import cocahappymachine.ui.LoadingDialog;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.media.Camera;
	import flash.utils.getDefinitionByName;
	import Resources.CouponViewDialog;
	import Resources.CouponConfirmDialog;
	import flash.display.LoaderInfo;
	import cocahappymachine.util.DebugConsole;
	import cocahappymachine.util.Debug;
	import cocahappymachine.util.InputableDebugConsole;
	import cocahappymachine.util.DebugEvent;
	import cocahappymachine.util.DragManager;
	
	
	public class CocaCode extends MovieClip {
		
		private var loadDialog:LoadingDialog;
		private var state:int;
		
		public function CocaCode() {
			DragManager.getInstance().setStage(this.stage);
			//---- display loading dialog ----
			startLoading();
			
			var debugConsole:InputableDebugConsole = new InputableDebugConsole(stage.stageWidth, stage.stageHeight);
//			this.addChild(debugConsole);
			
			//---- load data ----
			/*var facebookId:String = LoaderInfo(this.root.loaderInfo).parameters.userFacebookId.toString();
			
			SystemConstructor.getInstance().setFacebookId(facebookId);*/
			SystemConstructor.getInstance().setFacebookId("1111");
			
			SystemConstructor.getInstance().construct(onSystemComplete);
			Debug.getInstance().debug("Load Data Complete");
			//Debug.getInstance().debug("This is Facebook Id : " + facebookId);
			//Debug.getInstance().debug("This is Facebook Name : " + facebookName);
			//---- Load External Symbol ----
			var path:URLRequest = new URLRequest("Resources.swf");
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoadComplete);
			loader.load(path,context);
			Debug.getInstance().debug("Load External Complete");
		}		

		public function onSystemComplete(player:Player){
			Debug.getInstance().debug("all load complete");
			startGame();
		}
		
		//---- Callback function for Load External Symbol testing
		//---- for single instance symbole such as dialog, 
		//---- add them to stage and set visible to false
		public function onSWFLoadComplete(event:Event){
			Debug.getInstance().debug("Asset load Complete");
		}
		
		private function startLoading(){
			loadDialog = new LoadingDialog();
			this.addChild(loadDialog);
		}
		
		private function startGame(){
			this.removeChild(loadDialog);
			var game:GamePlay = new GamePlay();
			this.addChildAt(game, 0);
		}

	}
}