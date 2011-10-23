package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class SpecialCodeDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static var DIALOG_CONFIRM:String = "DIALOG_CONFIRM";

		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public var codeField:TextField;
		
		public function SpecialCodeDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function getCode():String{
			return codeField.text;
		}
		
		public function onConfirmButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CONFIRM));
		}
	}
	
}
