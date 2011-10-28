package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	public class OccupyDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		
		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public var levelField:TextField;
		public var moneyField:TextField;
		
		public function OccupyDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function setData(requiredLevel:int, requiredMoney:int, isLevel:Boolean, isMoney:Boolean){
			levelField.text = requiredLevel.toString();
			moneyField.text = requiredMoney.toString();
			if(isLevel){
				levelField.textColor = 0x000000;
			} else {
				levelField.textColor = 0xFF0000;
			}
			if(isMoney){
				moneyField.textColor = 0x000000;
			} else {
				moneyField.textColor = 0xFF0000;
			}
			if(isLevel && isMoney){
				confirmButton.visible = true;
			} else {
//				confirmButton.visible = false;
			}
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onConfirmButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CONFIRM));
		}
	}
	
}
