package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class StatusUI extends MovieClip {
		
		public var nameField:TextField;
		public var levelField:TextField;
		public var progressMC:MovieClip;
		public var numberMC:MovieClip;
		
		public function StatusUI() {
			// constructor code
		}
		
		public function setName(name:String){
			nameField.text = name + "'s Land";
		}
		
		public function setNumberMC(mc:MovieClip){
			while(numberMC.numChildren != 0){
				numberMC.removeChildAt(0);
			}
			numberMC.addChild(mc);
		}
		
		public function setProgressMC(progress:MovieClip){
			this.progressMC.addChild(progress);
		}
	}
	
}
