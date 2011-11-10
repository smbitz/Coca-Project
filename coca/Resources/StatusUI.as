package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class StatusUI extends MovieClip {
		
		public var nameField:TextField;
		public var levelField:TextField;
		public var progressMC:MovieClip;
		
		public function StatusUI() {
			// constructor code
		}
		
		public function setName(name:String){
			nameField.text = name + "'s Land";
		}
		
		public function setLevel(lv:String){
			levelField.text = lv;
		}
		
		public function setProgressMC(progress:MovieClip){
			this.progressMC.addChild(progress);
		}
	}
	
}
