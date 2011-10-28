package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.Building;
	import flash.text.TextField;
	
	
	public class BuildItemBox extends MovieClip {
		
		private var id:String;
		private var isBuildable:Boolean;
		
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
		
		public function setBuildable(isBuildable:Boolean){
			this.isBuildable = isBuildable;
			if(!isBuildable){
				this.graphics.beginFill(0xFF0000, 1);
				this.graphics.drawRect(-15, 0, 15, 15);
				this.graphics.endFill();
			}
		}
		
		public function getBuildable():Boolean{
			return isBuildable;
		}
	}
}
