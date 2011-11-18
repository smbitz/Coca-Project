package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.ui.AbstractFarmTile;
	
	
	public class EmptyFarmTile extends AbstractFarmTile {
		
		
		public function EmptyFarmTile() {
			// constructor code
			glowFilter.knockout = true;
			glowFilter.blurX = 20;
			glowFilter.blurY = 20;
			glowFilter.strength = 3;
			bubble.visible = false;
		}
	}
	
}