package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class BuildPanel extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";

		public var closeButton:MovieClip;
		
		public function BuildPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
