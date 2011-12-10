package cocahappymachine.ui {
	import flash.events.Event;
	
	public class LoadEvent extends Event {

		private var loadProgress:int;
		
		public function LoadEvent(type:String, progress:int) {
			super(type);
			loadProgress = progress;
		}
		
		public function getProgress():int{
			return loadProgress;
		}

	}
	
}
