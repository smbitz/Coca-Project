package cocahappymachine.util {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class Debug extends EventDispatcher {

		public static const INPUT_RECEIVE:String = "INPUT_RECEIVE";
		
		private static var instance:Debug = null;
		private var console:DebugConsole;
		
		public function Debug() {
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
		}

		public static function getInstance() {
			if(instance == null){
				instance = new Debug();
			}
			return instance;
		}
		
		public function setConsole(console:DebugConsole){
			this.console = console;
			if(console is InputableDebugConsole){
				var dc:InputableDebugConsole = InputableDebugConsole(console);
				dc.addEventListener(InputableDebugConsole.INPUT_RECEIVE, onInputReceive);
			}
		}
		
		public function debug(content:String){
			console.addLine(content);
		}
		
		public function onInputReceive(event:DebugEvent){
			this.dispatchEvent(new DebugEvent(INPUT_RECEIVE, event.getInputText()));
		}
	}
	
}
