package cocahappymachine.ui {
	
	import flash.display.MovieClip;
	
	public class ProgressBar extends MovieClip {

		private var progressMC:MovieClip;
		private var progressWidth:int;
		private var progress:Number;
		
		public function progressBar() {
		}

		public function setProgress(progress:Number){
			this.progress = progress;
			calculate();
		}
		
		public function setMC(progressMC:MovieClip){
			this.progressMC = progressMC;
			this.addChild(progressMC);
			calculate();
		}
		
		public function setSize(pWidth:int){
			progressWidth = pWidth;
			calculate();
		}
		
		private function calculate(){
			if(progressMC != null){
				var w:int = progress * progressWidth;
				progressMC.width = w;
			}
		}
	}
}