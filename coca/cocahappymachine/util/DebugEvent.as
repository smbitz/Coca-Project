package cocahappymachine.util {
	import flash.events.Event;
	
	public class DebugEvent extends Event {

		private var inputText:String;
		
		public function DebugEvent(type:String, inputText:String) {
			super(type);
			this.inputText = inputText;
		}

		public function getInputText():String{
			return inputText;
		}
	}
	
}
