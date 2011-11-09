package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import cocahappymachine.ui.ShopEvent;
	
	public class ShopSellItemBox extends MovieClip {
		
		public static const SELL:String = "SELL";
		private var itemId:String;
		
		public var nameField:TextField;
		public var quantityField:TextField;
		public var priceField:TextField;
		public var sellButton:SimpleButton;
		
		public function ShopSellItemBox() {
			sellButton.addEventListener(MouseEvent.CLICK, onSell);
		}
		
		public function setItemId(itemId:String){
			this.itemId = itemId;
		}
		
		public function getItemId():String{
			return itemId;
		}

		public function setName(n:String){
			nameField.text = n;
		}
		
		public function setQuantity(q:int){
			quantityField.text = "x " + q;
		}
		
		public function setPrice(p:int){
			priceField.text = p.toString();
		}
		
		public function onSell(event:MouseEvent){
			var e:ShopEvent = new ShopEvent(SELL);
			e.setItemId(itemId);
			this.dispatchEvent(e);
		}

	}
	
}
