package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class LevelUpDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var numberMC:MovieClip;
		public var closeButton:SimpleButton;
		
		public function LevelUpDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function setNumberMC(mc:MovieClip){
			while(numberMC.numChildren != 0){
				numberMC.removeChildAt(0);
			}
			numberMC.addChild(mc);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
