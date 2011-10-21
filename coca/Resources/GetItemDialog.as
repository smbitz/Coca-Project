package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	
	public class GetItemDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var getItemBox1:MovieClip;
		public var getItemBox2:MovieClip;
		public var getItemBox3:MovieClip;
		
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
