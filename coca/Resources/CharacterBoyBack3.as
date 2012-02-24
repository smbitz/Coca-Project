package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;	
	
	public class CharacterBoyBack3 extends MovieClip {
		
		
		public function CharacterBoyBack3() {
			// constructor code
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event){
			if(this.currentFrame == this.totalFrames){
				this.stop();
			}
		}
	}
	
}
