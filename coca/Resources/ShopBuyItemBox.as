package Resources {
	
	import flash.display.MovieClip;
	
	
	public class ShopBuyItemBox extends MovieClip {
		
		private var itemId:String;
		
		public function ShopBuyItemBox() {
			// constructor code
		}
		
		public function setItemId(itemId:String){
			this.itemId = itemId;
		}
		
		public function getItemId():String{
			return itemId;
		}

	}
	
}
