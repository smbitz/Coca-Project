package cocahappymachine.util {
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class DebugConsole extends MovieClip {

		protected static const MARGIN_X:int = 20;
		protected static const MARGIN_Y:int = 10;
		protected static const HEIGHT:int = 130;
		protected static const ROUND_CORNER:int = 20;
		
		protected var stageWidth:int;
		protected var stageHeight:int;
		
		protected var text:TextField;
		protected var bg:MovieClip;
		
		public function DebugConsole(stageWidth:int, stageHeight:int) {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			bg = new MovieClip();
			bg.graphics.beginFill(0xAAAAAA, 0.3);
			bg.graphics.drawRoundRect(MARGIN_X, stageHeight - HEIGHT - MARGIN_Y, 
							stageWidth - MARGIN_X - MARGIN_X,HEIGHT, ROUND_CORNER);
			bg.graphics.endFill();
			this.addChild(bg);
			text = new TextField();
			text.multiline = true;
			text.selectable = false;
			text.x = MARGIN_X + ROUND_CORNER / 2;
			text.y = stageHeight - HEIGHT - MARGIN_Y;
			text.width = stageWidth - MARGIN_X - MARGIN_X - ROUND_CORNER;
			text.height = HEIGHT;
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