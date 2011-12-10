package cocahappymachine.ui {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class LoadingPage extends MovieClip {
		
		public var percentText:TextField;
		public var branchText:TextField;
		
		public function LoadingPage() {
			// constructor code
		}
		
		public function setPercent(i:int){
			percentText.text = "LOADING " + i + "%";
		}
	}
	
}
