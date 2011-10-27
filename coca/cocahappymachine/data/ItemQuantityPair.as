package cocahappymachine.data {
	
	//ItemQuantityPair
	public class ItemQuantityPair {

		private var itemId:String;
		private var quantity:int;
		
		private var item:Item;
		
		public function ItemQuantityPair() {
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
			return this.itemId;
		}
		
		public function getItemQty():int{
			return this.quantity
		}
		
		public function getItem():Item{
			return this.item;
		}
		
		public function setItemId(setValue:String){
			this.itemId = setValue;
		}
		
		public function setItem(setValue:Item){
			this.item = setValue;
		}
		
		public function setItemQty(setValue:int){
			this.quantity = setValue;
		}
	}
	
}
