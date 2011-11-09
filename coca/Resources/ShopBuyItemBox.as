package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	
	
	public class ShopBuyItemBox extends MovieClip {
		
		private var itemId:String;
		
		public var nameField:TextField;
		public var quantityField:TextField;
		public var priceField:TextField;
		public var sellButton:SimpleButton;
		
		public function ShopBuyItemBox() {
			// constructor code
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
	}
	
}
