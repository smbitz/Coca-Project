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
	import flash.utils.getDefinitionByName;
	import Resources.CouponViewDialog;
	import Resources.CouponConfirmDialog;
	import flash.display.LoaderInfo;
	import cocahappymachine.util.DebugConsole;
	import cocahappymachine.util.Debug;
	import cocahappymachine.util.InputableDebugConsole;
	import cocahappymachine.util.DebugEvent;
	import cocahappymachine.util.DragManager;
	import cocahappymachine.ui.LoadingPage;	
	import cocahappymachine.ui.LoadEvent;
	
	public class CocaCode extends MovieClip {
		
		private var loadDialog:LoadingPage;
		private var state:int;
		
		public function CocaCode() {
			DragManager.getInstance().setStage(this.stage);
			//---- display loading dialog ----
			startLoading();
			
			var debugConsole:InputableDebugConsole = new InputableDebugConsole(stage.stageWidth, stage.stageHeight);
//			this.addChild(debugConsole);
			
			//---- load data ----
			/*
			var facebookId:String = LoaderInfo(this.root.loaderInfo).parameters.userFacebookId.toString();
			var facebookName:String = LoaderInfo(this.root.loaderInfo).parameters.userFacebookName.toString();
			var facebookGender:String = LoaderInfo(this.root.loaderInfo).parameters.userGender.toString();
			
			SystemConstructor.getInstance().setFacebookId(facebookId);
			SystemConstructor.getInstance().setPlayerName(facebookName);
			*/
			
			SystemConstructor.getInstance().addEventListener(SystemConstructor.LOAD_PROGRESS, onLoadProgress);
			SystemConstructor.getInstance().setFacebookId("4321");
			SystemConstructor.getInstance().setPlayerName("Name");
			
			SystemConstructor.getInstance().construct(onSystemComplete);
			Debug.getInstance().debug("Load Data Complete");
		}		
		
		public function onLoadProgress(event:LoadEvent){
			loadDialog.setPercent(event.getProgress());
		}

		public function onSystemComplete(player:Player){
			Debug.getInstance().debug("all load complete");
			startGame();
		}
		
		private function startLoading(){
			loadDialog = new LoadingPage();
			this.addChild(loadDialog);
		}
		
		private function startGame(){
			this.removeChild(loadDialog);
			var game:GamePlay = new GamePlay(this.stage);
			this.addChildAt(game, 0);
		}

	}
}