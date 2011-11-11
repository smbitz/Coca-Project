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
		
		public function setName(n:String){
		}
		
		public function setItemQuantity(i:int){
		}

		public function setItemRequire(i:int){
		}
		
		public function setPicture(mc:MovieClip){
		}
	}
	
}
