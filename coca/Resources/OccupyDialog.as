package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class OccupyDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		
		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		
		public function OccupyDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function setData(requiredLevel:int, requiredMoney:int, isLevel:Boolean, isMoney:Boolean){
			//set level, money required to purchase
			//if isLevel == false
				//change color or style output
			//if isMoney == false
				//change color or style output
			//if one of them false
				//disable confirm button
			//else
				//enable confirm button
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onConfirmButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CONFIRM));
		}
	}
	
}
