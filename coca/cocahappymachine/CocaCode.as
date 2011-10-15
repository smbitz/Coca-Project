package cocahappymachine {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.SystemConstructor;
	import cocahappymachine.data.Player;
	
	
	public class CocaCode extends MovieClip {
		
		public function CocaCode() {
			SystemConstructor.getInstance().construct(onSystemComplete);
		}		

		public function onSystemComplete(player:Player){
			trace("all load complete");
			//start game
		}
	}
	
}
