package cocahappymachine.data {
	
	public class Item {

		private var id:String;
		private var name:String;
		private var price:int;
		private var itemType:String;
		
		public function Item() {
		}

		public function setDataFromXmlNode(var xml:XML){
			
		}
		
		private class ExchangeItem {
			private var id:String;
			private var quantity:int;
			
			private var item:Item;
		}
	}
	
}
