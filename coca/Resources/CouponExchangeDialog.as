package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	
	public class CouponExchangeDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var leftButton:SimpleButton;
		public var rightButton:SimpleButton;
		
		public function CouponExchangeDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.visible = false;
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
