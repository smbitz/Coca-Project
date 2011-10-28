package cocahappymachine.data {
	
	public class Tile {

		public static const BUILDING_EMPTY:int = 1;
		public static const BUILDING_PROCESS1:int = 2;
		public static const BUILDING_PROCESS2:int = 3;
		public static const BUILDING_COMPLETED:int = 4;
		public static const BUILDING_ROTTED:int = 5;
		public static const BUILDING_NOTOCCUPY:int = 6;
		
		private var landType:String;
		private var isOccupy:Boolean;
		private var buildingId:String;
		private var progress:int;
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
					if(tileAttributes=="true"){
						isOccupy = true;
					}else{
						isOccupy = false;
					}
				}else if (tileAttributes.name()=="building_id") {
					buildingId = tileAttributes;
				}else if (tileAttributes.name()=="progress") {
					progress = (int(tileAttributes)*1000);
				}else if (tileAttributes.name()=="supply_left") {
					supply = int(tileAttributes);
				}else if (tileAttributes.name()=="extra_id") {
					extraId = tileAttributes;
				}else if (tileAttributes.name()=="rotten_period") {
					rottenPeriod = (int(tileAttributes)*1000);
				}
			}
		}
		
		public function getBuildingStatus():int{
			if(!isOccupy){
				return BUILDING_NOTOCCUPY;
			}
			if(building){
				if(progress<=(building.getBuildPeriod()*0.5)){
					//if progress <= 50%
					return BUILDING_PROCESS1;
				} else if(progress>(building.getBuildPeriod()*0.5)&&progress<building.getBuildPeriod()){
					//if progress >50% AND < 100%
					return BUILDING_PROCESS2;
				} else if(progress>=building.getBuildPeriod()&&rottenPeriod>0){
					//if progress >= 100% (but not rotted)
					return BUILDING_COMPLETED;
				} else {
					//if rotten < 0
					return BUILDING_ROTTED;
				}
			} else {
				return BUILDING_EMPTY;
			}
		}
		
		public function update(elapse:int){
			if(building){
				var buildingStatus:int = this.getBuildingStatus();
				if(buildingStatus == BUILDING_EMPTY){
					//update elapse with nothing
				} else if(buildingStatus == BUILDING_PROCESS1){
					//update elapse with progress
					if(this.supply>0){
						this.progress += elapse;
						this.supply -= elapse;
					}
					buildingStatus = this.getBuildingStatus();
				} else if(buildingStatus == BUILDING_PROCESS2){
					//update elapse with progress
					if(this.supply>0){
						this.progress += elapse;
						this.supply -= elapse;
					}
					buildingStatus = this.getBuildingStatus();
				} else if(buildingStatus == BUILDING_COMPLETED){
					//update elapse with rotten
					this.rottenPeriod -= elapse;
					buildingStatus = this.getBuildingStatus();
				} else if(buildingStatus == BUILDING_ROTTED){
					//update elapse with nothing
				}
			}
		}
		
		public function getBuildingId():String{
			return this.buildingId;
		}
		
		public function getBuilding():Building{
			return this.building;
		}
		
		public function getIsOccupy():Boolean{
			return this.isOccupy;
		}
		
		public function setBuilding(setValue:Building){
			this.building = setValue;
		}
		
		public function setSupply(setValue:int){
			this.supply = setValue;
		}
		
		public function setExtraId(setValue:String){
			this.extraId = setValue;
		}
		
		public function setIsOccupy(setValue:Boolean){
			this.isOccupy = setValue;
		}
		
		public function setBuildingId(setValue:String){
			this.buildingId = setValue;
		}
		
		public function setProgress(setValue:int){
			this.progress = setValue;
		}
		
		public function setRottenPeriod(setValue:int){
			this.rottenPeriod = setValue;
		}
		
		//player.build(1, 1, "1");
		public function build(building:Building){
			this.buildingId = building.getId();
			this.progress = 0;
			this.supply = 0;
			this.extraId = "NULL";
			this.rottenPeriod = building.getRottenPeriod();
			
			this.setBuilding(BuildingManager.getInstance().getMatchBuilding(this.buildingId));
		}
		
		public function isAllowToBuild(building:Building):Boolean{
			if(landType=="land" && building.getBuildingType()=="vege" && isOccupy==true||
			   landType=="land" && building.getBuildingType()=="meat" && isOccupy==true||
			   landType=="sea" && building.getBuildingType()=="sea" && isOccupy==true){
				   return true;
			   } else {
				   return false;
			   }
		}

	}
	
}