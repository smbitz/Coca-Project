package cocahappymachine.data {
	
	public class ItemExchangeItem {
		private var id:String;
		private var quantity:int;
		
		private var item:Item;
		
		public function ItemExchangeItem() {
		}
		
		public function setDataFromNode(setId:String,setQuantity:int){
			id = setId;
			quantity = setQuantity;
		}
		
		public function getId():String{
			return id;
		}
		
		public function getItem():Item{
			return item;
		}
		
		public function setItem(setValue:Item){
			item = setValue;
		}
	}
	
}
