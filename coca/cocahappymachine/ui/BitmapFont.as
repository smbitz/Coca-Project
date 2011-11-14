package cocahappymachine.ui {
	import flash.display.MovieClip;
	
	public class BitmapFont {

		private var constructor:AbstractBitMapConstructor;
		
		public function BitmapFont(constructor:AbstractBitMapConstructor) {
			this.constructor = constructor;
		}

		public function getMovieClip(text:String):MovieClip {
			var mc:MovieClip = new MovieClip();
			for(var i:int = 0; i < text.length; i++){
				var c:String = text.charAt(i);
				var cMC:MovieClip = constructor.getChar(c);
				mc.addChild(cMC);
			}
			return mc;
		}
	}
}