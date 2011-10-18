package cocahappymachine.data {
	
	public class BuildingExtra {
		
		private var id:String;
		private var result:int;
		
		private var item:Item;
		
		public function BuildingExtra() {
		}
		
		public function setDataFromNode(setId:String,setResult:int){
			id = setId;
			result = setResult;
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
