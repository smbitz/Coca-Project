package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	public class GetItemDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var wordField:TextField;
		
		public function GetItemDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		//---- set display data from list before display ----//
		//list:Array is an array of [Item, quantity]
		public function setData(list:Array){
			
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
