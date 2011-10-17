package cocahappymachine.data {
	
	public class Tile {

		private var landType:String;
		private var isOccupy:Boolean;
		private var buildingId:String;
		private var progess:int;
		private var supply:int;
		private var extraId:String;
		private var rottenPeriod:int;
		
		private var building:Building2;
		
		public function Tile() {
		}
		
		public function setDataFromXmlNode(var xml:XML){
			
		}
	}
	
}