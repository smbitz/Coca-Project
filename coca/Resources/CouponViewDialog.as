package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class CouponViewDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var couponText:TextField;
		
		public function CouponViewDialog() {
			// constructor code
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function setCounpon(text:String){
			couponText.text = text;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
