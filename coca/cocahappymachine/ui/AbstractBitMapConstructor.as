package cocahappymachine.ui {
	import flash.display.MovieClip;
	
	public class AbstractBitMapConstructor {

		private var charBitmapArray:Array;
		
		public function AbstractBitMapConstructor() {
			charBitmapArray = new Array();
		}

		public function getChar(c:String):MovieClip{
			return new charBitmapArray['0']();
		}
		
		protected function addChar(char:String, mcClass:Class){
			charBitmapArray[char] = mcClass;
		}

	}
	
}
