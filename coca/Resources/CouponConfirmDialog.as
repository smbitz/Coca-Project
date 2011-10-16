package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class CouponConfirmDialog extends MovieClip {
		
		
		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static var DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		
		public function CouponConfirmDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.visible = false;
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onConfirmButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CONFIRM));
		}
	}
}
