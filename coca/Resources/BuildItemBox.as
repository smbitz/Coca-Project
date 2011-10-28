package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.Building;
	import flash.text.TextField;
	
	
	public class BuildItemBox extends MovieClip {
		
		private var id:String;
		
		public var titleField:TextField;
		
		public function BuildItemBox() {
		}
		
		//---- set data Object using for identity building associate with BuildItemBox
		public function setBuildingId(id:String){
			this.id = id;
		}
		
		public function getBuildingId():String{
			return id;
		}
		
		public function setTitle(title:String){
			titleField.text = title;
		}
	}
}
