package cocahappymachine.util {
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class DebugConsole extends MovieClip{

		private static const MARGIN_X:int = 20;
		private static const MARGIN_Y:int = 20;
		private static const HEIGHT:int = 120;
		private static const ROUND_CORNER:int = 20;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var text:TextField;
		private var bg:MovieClip;
		
		public function DebugConsole(stageWidth:int, stageHeight:int) {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			bg = new MovieClip();
			bg.graphics.beginFill(0xFF0000, 0.3);
			bg.graphics.drawRoundRect(MARGIN_X, stageHeight - HEIGHT - MARGIN_Y, 
							stageWidth - MARGIN_X - MARGIN_X,HEIGHT, ROUND_CORNER);
			bg.graphics.endFill();
			this.addChild(bg);
			text = new TextField();
			text.multiline = true;
			text.selectable = false;
			text.x = MARGIN_X + ROUND_CORNER / 2;
			text.y = stageHeight - HEIGHT - MARGIN_Y + ROUND_CORNER / 2;
			text.width = stageWidth - MARGIN_X - MARGIN_X - ROUND_CORNER;
			text.height = HEIGHT - ROUND_CORNER;
			this.addChild(text);
			Debug.getInstance().setConsole(this);
		}
		
		public function addLine(content:String){
			if(text.text.length != 0){
				text.appendText("\n");
			}
			text.appendText(content);
			text.scrollV = text.maxScrollV;
		}

	}
}