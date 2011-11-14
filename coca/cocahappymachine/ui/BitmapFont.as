package cocahappymachine.ui {
	import flash.display.MovieClip;
	
	public class BitmapFont {

		private var constructor:AbstractBitmapConstructor;
		
		public static const H_CENTER:int = 0x0100;
		public static const LEFT:int = 0x1000;
		public static const RIGHT:int = 0x1100;
		public static const V_CENTER:int = 0x0001;
		public static const TOP:int = 0x0010;
		public static const BOTTOM:int = 0x0011;
		
		public function BitmapFont(constructor:AbstractBitmapConstructor) {
			this.constructor = constructor;
		}

		public function getMovieClip(text:String, align:int):MovieClip {
			var hAlign:int = align & 0x1100;
			var vAlign:int = align & 0x0011;
			var mc:MovieClip = new MovieClip();
			for(var i:int = 0; i < text.length; i++){
				var cMC:MovieClip = constructor.getChar(text.charAt(i));
				cMC.x = mc.width;
				mc.addChild(cMC);
				if(hAlign == H_CENTER){
					mc.x = - mc.width / 2;
				} else if(hAlign == RIGHT){
					mc.x = - mc.width;
				}
			}
			return mc;
		}
	}
}