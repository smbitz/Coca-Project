package cocahappymachine.ui {
	
	import flash.events.Event;
	
	public class ShopEvent extends Event {

		public static const BUY:String = "BUY";
		public static const SELL:String = "SELL";
		
		private var itemId:String;
		
		public function ShopEvent(type:String) {
			super(type);
		}
		
		public function setItemId(id:String){
			itemId = id;
		}

		public function getItemId():String{
			return itemId;
		}
	}
	
}
