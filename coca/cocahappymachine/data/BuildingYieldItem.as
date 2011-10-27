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
			return this.id;
		}
		
		public function getItem():Item{
			return this.item;
		}
		
		public function getQuantity():int{
			return this.quantity;
		}
		
		public function getChance():int{
			return this.chance;
		}
		
		public function getRandomTime():int{
			return this.randomTime;
		}
		
		public function setItem(setValue:Item){
			this.item = setValue;
		}
	}
	
}
