package cocahappymachine.ui {
	import flash.events.Event;
	
	public class CouponEvent extends Event {

		private var itemId:String;
		
		private var temp:int;
		
		public function CouponEvent(type:String) {
			super(type);
		}
		
		public function setItemId(itemId:String){
			this.itemId = itemId;
		}
		
		public function getItemId():String{
			return itemId;
		}

	}
	
}
