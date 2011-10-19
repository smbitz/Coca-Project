package cocahappymachine.util {
	
	public class Debug {

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
		}
		
		public function debug(content:String){
			console.addLine(content);
		}
	}
	
}
