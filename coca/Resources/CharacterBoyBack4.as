﻿package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class CharacterBoyBack4 extends MovieClip {
		
		
		public function CharacterBoyBack4() {
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
