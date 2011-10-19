package cocahappymachine.util {
	
	import flash.utils.Timer;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class GameTimer extends EventDispatcher {
		
		private static const ELAPSE:int = 30;
		
		private var previousTime:int;
		private var currentTime:int;
		
		public static const GAMETIMER_RUN = "GAMETIMER_RUN";
		private var timer:Timer;
		
		public function GameTimer() {
			timer = new Timer(ELAPSE);
			timer.addEventListener(TimerEvent.TIMER, onRun);
		}
		
		public function start(){
			timer.start();
			var d:Date = new Date();
			previousTime = d.getTime();
		}
		
		public function stop(){
			timer.stop();
		}
		
		public function onRun(event:TimerEvent){
			var d:Date = new Date();
			currentTime = d.getTime();
			var elapse:int = currentTime - previousTime;
			previousTime = currentTime;
			
			this.dispatchEvent(new GameTimerEvent(GAMETIMER_RUN, elapse) );
		}
	}
}