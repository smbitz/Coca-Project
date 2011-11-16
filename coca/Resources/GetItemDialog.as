package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import cocahappymachine.data.ItemQuantityPair;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	
	public class GetItemDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var wordField:TextField;
		public var itemMC:MovieClip;
		
		public function GetItemDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function setData(mc:DisplayObject, itemPair:ItemQuantityPair){
			wordField.text = "คุณได้รับ " + itemPair.getItem().getName() + " " + itemPair.getItemQty() + " EA.";
			while(itemMC.numChildren != 0){
				itemMC.removeChildAt(0);
			}
			itemMC.addChild(mc);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
