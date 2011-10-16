package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class CouponViewDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		
		public function CouponViewDialog() {
			// constructor code
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.visible = false;
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
