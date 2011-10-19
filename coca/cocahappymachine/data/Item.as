package cocahappymachine.data {
	
	public class Item {

		private var id:String;
		private var name:String;
		private var price:int;
		private var itemType:String;
		
		private var exchangeItem:Array;
		
		public function Item() {
			exchangeItem = new Array();
		}

		public function setDataFromXmlNode(xml:XML){
			//Temp.
			var exchangeId:String;
			var exchangeQuantity:int;
			
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
			
			//Item Exchange
			for(var a:int = 0; a<xml.exchange_item.length(); a++){
				exchangeId = xml.exchange_item[a].attribute("id");
				exchangeQuantity = xml.exchange_item[a].attribute("quantity");
				
				var newExchangeItem:ItemExchangeItem = new ItemExchangeItem();
				newExchangeItem.setDataFromNode(exchangeId,exchangeQuantity);
				exchangeItem.push(newExchangeItem);
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
		
		public function getExchangeItem():Array{
			return exchangeItem;
		}
	}
	
}
