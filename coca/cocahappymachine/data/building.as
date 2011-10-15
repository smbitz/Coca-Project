package cocahappymachine.data {
	
	public class building {

		private var id:String;
		private var name:String;
		private var buildingType:String;
		private var buildPeriod:int;
		private var supplyId:int;
		private var supplyPeriod:int;
		private var buildItemId:int;
		private var rottenPeriod:int;
		private var extra:Array		// array of Extra
		private var yieldItem:Array	// array of YieldItem
		
		private var buildItem:Item;
		private var supplyItem:Item;
		
		public function building() {
		}
		
		public function setDataFromXmlNode(var xml:XML){
			
		}
		
		private class Extra {
			public var id:String;
			public var result:int;
			
			public var item:Item;
		}
		
		private class YieldItem {
			public var id:String;
			public var quantity:int;
			public var chance:int;
			public var randomTime:int;
			
			public var item:Item;
		}

	}
	
}
