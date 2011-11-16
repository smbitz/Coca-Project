package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.ItemQuantityPair;
	
	public class ItemPairEvent extends Event{

		private var itemPair:ItemQuantityPair;
		
		public function ItemPairEvent(type:String) {
			super(type);
		}
		
		public function setItemPair(item:ItemQuantityPair){
			itemPair = item;
		}
		
		public function getItemPair():ItemQuantityPair{
			return itemPair;
		}
	}
}
