package cocahappymachine.data {
	
	public class Backpack {

		private var itemId:String;
		private var quantity:int;
		
		private var item:Item;
		
		public function Backpack() {
		}

		public function setDataFromXmlNode(xml:XML){
			//Get Backpack Detail
			for each(var itemAttributes:XML in xml.attributes()){
				if (itemAttributes.name()=="id") {
					itemId = itemAttributes;
				}else if (itemAttributes.name()=="quantity") {
					quantity = int(itemAttributes);
				}
			}
		}
		
		public function getItemId():String{
			return itemId;
		}
		
		public function getItemQty():int{
			return quantity
		}
		
		public function getItem():Item{
			return item;
		}
		
		public function setItem(setValue:Item){
			item = setValue;
		}
		
		public function setItemQty(setValue:int){
			quantity = setValue;
		}
	}
	
}
