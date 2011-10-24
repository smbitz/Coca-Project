package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.Building;
	
	
	public class BuildItemBox extends MovieClip {
		
		private var id:String;
		
		public function BuildItemBox() {
		}
		
		//---- set data Object using for identity building associate with BuildItemBox
		public function setBuildingId(id:String){
			this.id = id;
		}
		
		public function getBuildingId():String{
			return id;
		}
	}
}
