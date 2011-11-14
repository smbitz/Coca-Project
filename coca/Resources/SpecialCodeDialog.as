package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class SpecialCodeDialog extends MovieClip {
		
		private static const MESSAGE_NORMAL:String = "* รหัสคูปอง 8 หลัก";
		private static const MESSAGE_FAIL:String = "รหัสคูปองไม่ถูกต้อง กรุณาลองอีกครั้ง";
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static var DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		public static const COLOR_NORMAL:int = 0x0B91B5;
		public static const COLOR_FAIL:int = 0xFF3B00;

		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public var codeField:TextField;
		public var messageField:TextField;
		
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
		
		public function setMessage(isFail:Boolean){
			if(isFail){
				messageField.text = MESSAGE_FAIL;
				messageField.textColor = COLOR_FAIL;
			} else {
				messageField.text = MESSAGE_NORMAL;				
				messageField.textColor = COLOR_NORMAL;
			}
		}
	}
	
}
