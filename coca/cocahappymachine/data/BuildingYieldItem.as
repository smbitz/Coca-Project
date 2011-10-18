package cocahappymachine.data {
	
	public class BuildingYieldItem {
		private var id:String;
		private var quantity:int;
		private var chance:int;
		private var randomTime:int;
		
		private var item:Item;
		
		public function BuildingYieldItem() {
		}
		
		public function setDataFromNode(setId:String,setQuantity:int,setChance:int,setRandomTime:int){
			id = setId;
			quantity = setQuantity;
			chance = setChance;
			randomTime = setRandomTime;
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
