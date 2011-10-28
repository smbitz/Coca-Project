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
					buildPeriod = ((int(buildingAttributes)*60)*1000);
				}else if (buildingAttributes.name()=="supply_id") {
					supplyId = buildingAttributes;
				}else if (buildingAttributes.name()=="supply_period") {
					supplyPeriod = ((int(buildingAttributes)*60)*1000);
				}else if (buildingAttributes.name()=="build_item") {
					buildItemId = buildingAttributes;
				}else if (buildingAttributes.name()=="rotten_period") {
					rottenPeriod = ((int(buildingAttributes)*60)*1000);
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
				yieldRandomTime = xml.yield_item[j].attribute("random_time");
				
				var newYieldItem:BuildingYieldItem = new BuildingYieldItem();
				newYieldItem.setDataFromNode(yieldId,yieldQuantity,yieldChance,yieldRandomTime);
				yieldItem.push(newYieldItem);
			}
		}
		
		public function getId():String{
			return this.id;
		}
		
		public function getName():String{
			return this.name;
		}
		
		public function getSupplyId():String{
			return this.supplyId;
		}
		
		public function getBuildItemId():String{
			return this.buildItemId;
		}
		
		public function getExtra():Array{
			return this.extra;
		}
		
		public function getYieldItem():Array{
			return this.yieldItem;
		}
		
		public function getBuildItem():Item{
			return this.buildItem;
		}
		
		public function getSupplyItem():Item{
			return this.supplyItem;
		}
		
		public function getBuildingType():String{
			return this.buildingType;
		}
		
		public function getBuildPeriod():int{
			return this.buildPeriod;
		}
		
		public function getRottenPeriod():int{
			return this.rottenPeriod;
		}
		
		public function getSupplyPeriod():int{
			return this.supplyPeriod;
		}
		
		public function setBuildItem(setValue:Item){
			this.buildItem = setValue;
		}
		
		public function setSupplyItem(setValue:Item){
			this.supplyItem = setValue;
		}
		
		public function setRottenPeriod(setValue:int){
			this.rottenPeriod = setValue;
		}
		
		public function setSupplyPeriod(setValue:int){
			this.supplyPeriod = setValue;
		}
		
		//---- return extra item1  ----//
		public function getExtraItem1():Item{
			var extraItem1:Item = extra[0].getItem();
			return extraItem1;
		}
		
		//---- return extra item1  ----//
		public function getExtraItem2():Item{
			var extraItem2:Item = extra[1].getItem();
			return extraItem2;
		}
		
		public function generateYieldItem():Array {
			var totalYieldItem:Array = new Array();
			
			for each(var arrayOfYieldItem:BuildingYieldItem in yieldItem){
				if(arrayOfYieldItem.getId()!="money"){
					for(var c:int = 0; c < arrayOfYieldItem.getRandomTime(); c++){
						var randomChance:int = Math.random()*100;
						if(randomChance < arrayOfYieldItem.getChance()){
							var itemToPush:Item = arrayOfYieldItem.getItem();
							
							var newItemPair:ItemQuantityPair = new ItemQuantityPair();
							newItemPair.setItemQty(arrayOfYieldItem.getQuantity());
							newItemPair.setItem(itemToPush);
							totalYieldItem.push(newItemPair);
						}
					}
				}
			}
			return totalYieldItem;
		}
		
		public function generateYieldMoney():int {
			var totalYieldMoney = 0;
			
			for each(var arrayOfYieldItem:BuildingYieldItem in yieldItem){
				if(arrayOfYieldItem.getId()=="money"){
					for(var b:int = 0; b < arrayOfYieldItem.getRandomTime(); b++){
						var randomChance:int = Math.random()*100;
						if(randomChance < arrayOfYieldItem.getChance()){
							totalYieldMoney += arrayOfYieldItem.getQuantity();
						}
					}
				}
			}
			return totalYieldMoney;
		}
	}
}
