package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	public class NewspaperDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var html:TextField;
		public var closeButton:SimpleButton;
		
		public function NewspaperDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function setHTML(d:String){
			html.htmlText = d;
		}
	}
	
}