package cocahappymachine.data {
	
	public class Item {

		private var id:String;
		private var name:String;
		private var price:int;
		private var itemType:String;
		
		public function Item() {
		}

		public function setDataFromXmlNode(xml:XML){
			for each(var itemAttributes:XML in xml.attributes()){
				if (itemAttributes.name()=="id") {
					id = itemAttributes;
				}else if (itemAttributes.name()=="name") {
					name = itemAttributes;
				}else if (itemAttributes.name()=="buying_price") {
					price = int(itemAttributes);
				}else if (itemAttributes.name()=="item_type") {
					itemType = itemAttributes;
				}
			}
		}
		
		public function getId():String{
			return id;
		}
		
		public function getName():String{
			return name;
		}
		
		public function getPrice():int{
			return price;
		}
		
		public function getItemType():String{
			return itemType;
		}
	}
	
}
