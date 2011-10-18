package cocahappymachine.data {
	
	public class Tile {

		private var landType:String;
		private var isOccupy:Boolean;
		private var buildingId:String;
		private var progess:int;
		private var supply:int;
		private var extraId:String;
		private var rottenPeriod:int;
		
		private var building:Building;
		
		public function Tile() {
		}
		
		public function setDataFromXmlNode(xml:XML){
			//Get Land Detail
			for each(var tileAttributes:XML in xml.attributes()){
				if (tileAttributes.name()=="land_type") {
					landType = tileAttributes;
				}else if (tileAttributes.name()=="is_occupy") {
					isOccupy = Boolean(tileAttributes);
				}
			}
			
			//Get Building Detail
			for(var i:int = 0; i<xml.building.length(); i++){
				buildingId = xml.building.attribute("id");
				progess = xml.building.attribute("progress");
				supply = xml.building.attribute("supply_left");
				extraId = xml.building.attribute("extra_id");
				rottenPeriod = xml.building.attribute("rotten_period");
			}
		}
		
		public function getBuildingId():String{
			return buildingId;
		}
		
		public function setBuilding(setValue:Building){
			building = setValue;
		}
		
		public function getBuilding():Building{
			return building;
		}
	}
	
}