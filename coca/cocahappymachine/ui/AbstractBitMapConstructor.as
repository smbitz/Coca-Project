package cocahappymachine.ui {
	import flash.display.MovieClip;
	
	public class AbstractBitmapConstructor {

		private var charBitmapArray:Array;
		
		public function AbstractBitmapConstructor() {
			charBitmapArray = new Array();
		}

		public function getChar(c:String):MovieClip{
			return new charBitmapArray[c]();
		}
		
		protected function addChar(char:String, mcClass:Class){
			charBitmapArray[char] = mcClass;
		}

	}
	
}
