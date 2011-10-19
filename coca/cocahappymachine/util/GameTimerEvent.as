package cocahappymachine.util {
	import flash.events.Event;
	
	public class GameTimerEvent extends Event {

		private var elapse:int;
		
		public function GameTimerEvent(type:String, elapse:int) {
			super(type);
			this.elapse = elapse;
		}

		public function getElapse():int{
			return elapse;
		}
	}
	
}
