package cocahappymachine.util {
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	
	public class InputableDebugConsole extends DebugConsole {

		public static const INPUT_RECEIVE:String = "INPUT_RECEIVE";
		
		private static const INPUT_HEIGHT:int = 20
		
		private var inputText:TextField;
		
		public function InputableDebugConsole(stageWidth:int, stageHeight:int) {
			super(stageWidth, stageHeight);
			
			var bg:MovieClip = new MovieClip();
			bg.graphics.beginFill(0xAAAAAA, 0.5);
			bg.graphics.drawRoundRect(MARGIN_X, stageHeight, 
							stageWidth - MARGIN_X - MARGIN_X, INPUT_HEIGHT, 0);
			bg.graphics.endFill();
			this.addChild(bg);
			inputText = new TextField();
			inputText.type = TextFieldType.INPUT;
			inputText.multiline = false;
			inputText.selectable = true;
			inputText.x = MARGIN_X + ROUND_CORNER / 2;
			inputText.y = stageHeight;
			inputText.width = stageWidth - MARGIN_X - MARGIN_X - ROUND_CORNER;
			inputText.height = INPUT_HEIGHT;
			this.addChild(inputText);
			this.y -= INPUT_HEIGHT + MARGIN_Y;
			inputText.addEventListener(KeyboardEvent.KEY_DOWN, onInput);
		}
		
		public function onInput(event:KeyboardEvent){
			if(event.charCode == 13){
				var t:String = inputText.text;
				inputText.text = "";
				this.addLine(t);
				this.dispatchEvent(new DebugEvent(INPUT_RECEIVE, t));
			}
		}

	}
	
}