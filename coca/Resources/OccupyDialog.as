﻿package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	public class OccupyDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		
		private static const NOTENOUGH_COLOR:int = 0xFF3B00;
		private static const ENOUGH_COLOR:int = 0x431D1E;
		
		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public var levelField:TextField;
		public var moneyField:TextField;
		
		public function OccupyDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function setData(requiredLevel:int, requiredMoney:String, isLevel:Boolean, isMoney:Boolean){
			levelField.text = "LEVEL " + requiredLevel;
			moneyField.text = requiredMoney;
			if(isLevel){
				levelField.textColor = ENOUGH_COLOR;
			} else {
				levelField.textColor = NOTENOUGH_COLOR;
			}
			if(isMoney){
				moneyField.textColor = ENOUGH_COLOR;
			} else {
				moneyField.textColor = NOTENOUGH_COLOR;
			}
			if(isLevel && isMoney){
				confirmButton.visible = true;
			} else {
				confirmButton.visible = false;
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
