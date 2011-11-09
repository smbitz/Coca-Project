package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import cocahappymachine.ui.ShopEvent;
	
	
	public class ShopDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const BUY:String = "BUY";
		public static const SELL:String = "SELL";
		
		public var closeButton:SimpleButton;
		public var sellPaging:MovieClip;
		public var buyPaging:MovieClip;
		
		public function ShopDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		//---- buyList : Array of ShopBuyItemBox ----//
		public function setBuyItemBox(buyList:Array){
			for each(var box:ShopBuyItemBox in buyList){
			}
		}
		
		//---- buyList : Array of ShopSellItemBox ----//
		public function setSellItemBox(sellList:Array){
			for each(var box:ShopSellItemBox in sellList){
				box.addEventListener(ShopSellItemBox.SELL, onSell);
			}
		}
		
		public function setSellPaging(paging:MovieClip){
			sellPaging.addChild(paging);
		}
		
		public function setBuyPaging(paging:MovieClip){
			buyPaging.addChild(paging);
		}
		
		public function onSell(event:ShopEvent){
			var e:ShopEvent = new ShopEvent(SELL);
			e.setItemId(event.getItemId());
			this.dispatchEvent(e);
		}
	}
}