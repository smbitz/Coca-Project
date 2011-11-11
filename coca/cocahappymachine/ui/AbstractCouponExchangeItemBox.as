package cocahappymachine.ui {
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	public class AbstractCouponExchangeItemBox extends MovieClip {

		private var itemId:String;
		
		public function AbstractCouponExchangeItemBox() {

		}

		public function setItemId(itemId:String){
			this.itemId = itemId;
		}
		
		public function getItemId():String{
			return itemId;
		}
	}
	
}
