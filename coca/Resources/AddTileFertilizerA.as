﻿package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class AddTileFertilizerA extends MovieClip {
		
		
		public function AddTileFertilizerA() {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event){
			if(this.totalFrames == this.currentFrame){
				this.stop();
			}
		}
	}
	
}