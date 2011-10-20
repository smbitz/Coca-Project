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
				}else if (tileAttributes.name()=="building_id") {
					buildingId = tileAttributes;
				}else if (tileAttributes.name()=="progress") {
					progess = int(tileAttributes);
				}else if (tileAttributes.name()=="supply_left") {
					supply = int(tileAttributes);
				}else if (tileAttributes.name()=="extra_id") {
					extraId = tileAttributes;
				}else if (tileAttributes.name()=="rotten_period") {
					rottenPeriod = int(tileAttributes);
				}
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