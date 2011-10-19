package cocahappymachine.data {
	
	public class Building {

		private var id:String;
		private var name:String;
		private var buildingType:String;
		private var buildPeriod:int;
		private var supplyId:String;
		private var supplyPeriod:int;
		private var buildItemId:String;
		private var rottenPeriod:int;
		private var extra:Array		// array of Extra
		private var yieldItem:Array	// array of YieldItem
		
		private var buildItem:Item;
		private var supplyItem:Item;
		
		public function Building() {
			extra = new Array();
			yieldItem = new Array();
		}
		
		public function setDataFromXmlNode(xml:XML){
			//Temp.
			var extraId:String;  
			var extraResult:int; 
			
			var yieldId:String;
			var yieldQuantity:int;
			var yieldChance:int;
			var yieldRandomTime:int;
			
			for each(var buildingAttributes:XML in xml.attributes()){
				if (buildingAttributes.name()=="id") {
					id = buildingAttributes;
				}else if (buildingAttributes.name()=="name") {
					name = buildingAttributes;
				}else if (buildingAttributes.name()=="building_type") {
					buildingType = buildingAttributes;
				}else if (buildingAttributes.name()=="build_period") {
					buildPeriod = int(buildingAttributes);
				}else if (buildingAttributes.name()=="supply_id") {
					supplyId = buildingAttributes;
				}else if (buildingAttributes.name()=="supply_period") {
					supplyPeriod = int(buildingAttributes);
				}else if (buildingAttributes.name()=="build_item") {
					buildItemId = buildingAttributes;
				}else if (buildingAttributes.name()=="rotten_period") {
					rottenPeriod = int(buildingAttributes);
				}
			}
			
			//Building Extra
			for(var a:int = 0; a<xml.extra.length(); a++){
				extraId = xml.extra[a].attribute("id");
				extraResult = xml.extra[a].attribute("result");
				
				var newExtraBuilding:BuildingExtra = new BuildingExtra();
				newExtraBuilding.setDataFromNode(extraId,extraResult);
				extra.push(newExtraBuilding);
			}
			
			//Building Yield Item
			for(var j:int = 0; j<xml.yield_item.length(); j++){
				yieldId = xml.yield_item[j].attribute("id");
				yieldQuantity = xml.yield_item[j].attribute("quantity");
				yieldChance = xml.yield_item[j].attribute("chance");
				yieldRandomTime = xml.yield_item[j].attribute("randomTime");
				
				var newYieldItem:BuildingYieldItem = new BuildingYieldItem();
				newYieldItem.setDataFromNode(yieldId,yieldQuantity,yieldChance,yieldRandomTime);
				yieldItem.push(newYieldItem);
			}
		}
		
		public function getId():String{
			return id;
		}
		
		public function getName():String{
			return name;
		}
		
		public function getSupplyId():String{
			return supplyId;
		}
		
		public function getBuildItemId():String{
			return buildItemId;
		}
		
		public function getExtra():Array{
			return extra;
		}
		
		public function getYieldItem():Array{
			return yieldItem;
		}
		
		public function getBuildItem():Item{
			return buildItem;
		}
		
		public function getSupplyItem():Item{
			return supplyItem;
		}
		
		public function setBuildItem(setValue:Item){
			buildItem = setValue;
		}
		
		public function setSupplyItem(setValue:Item){
			supplyItem = setValue;
		}
	}
}
