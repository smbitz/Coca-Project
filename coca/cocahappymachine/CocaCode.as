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
	
	
	public class CocaCode extends MovieClip {
		
		private var loadDialog:LoadingDialog;
		
		public function CocaCode() {
			//---- display loading dialog ----
			loadDialog = new LoadingDialog();
			this.addChild(loadDialog);
			
			//---- load data ----
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
			this.removeChild(loadDialog);
		}
		
		//Callback function for Load External Symbol testing
		//for single instance symbole such as dialog, add them to stage and set visible to false
		public function runtimeAssetsLoadComplete(event:Event){
			trace("Asset load Complete");
			var mc:CouponConfirmDialog = new CouponConfirmDialog();
			mc.addEventListener(CouponViewDialog.DIALOG_CLOSE, onCouponDialogClose);
			this.addChild(mc);
		}
		
		public function onCouponDialogClose(event:Event){
			trace("Coupon Dialog Close");
		}
	}
}