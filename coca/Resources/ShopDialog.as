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
		public var buyLeftButton:SimpleButton;
		public var buyRightButton:SimpleButton;
		public var sellLeftButton:SimpleButton;
		public var sellRightButton:SimpleButton;
		
		public function ShopDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		//---- buyList : Array of ShopBuyItemBox ----//
		public function setBuyItemBox(buyList:Array){
			for each(var box:ShopBuyItemBox in buyList){
				box.addEventListener(ShopBuyItemBox.BUY, onBuy);
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
		
		public function onBuy(event:ShopEvent){
			var e:ShopEvent = new ShopEvent(BUY);
			e.setItemId(event.getItemId());
			this.dispatchEvent(e);
		}
		public function getBuyLeftButton():SimpleButton{
			return buyLeftButton;
		}
		public function getBuyRightButton():SimpleButton{
			return buyRightButton;
		}
		public function getSellLeftButton():SimpleButton{
			return sellLeftButton;
		}
		public function getSellRightButton():SimpleButton{
			return sellRightButton;
		}
	}
}