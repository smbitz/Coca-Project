package Resources {
	
	import flash.display.MovieClip;
	
	
	public class ShopSellItemBox extends MovieClip {
		
		private var itemId:String;
		
		public function ShopSellItemBox() {
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
