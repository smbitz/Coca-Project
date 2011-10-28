package cocahappymachine.ui {
	
	import flash.events.Event;
	
	public class BuildEvent extends Event {

		private var buildingId:String;
		
		public function BuildEvent(type:String) {
			super(type);
		}
		
		public function setBuildingId(id:String){
			buildingId = id;
		}

		public function getBuildingId():String{
			return buildingId;
		}
	}
	
}
