﻿package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class AddTileVaccineB extends MovieClip {
		
		
		public function AddTileVaccineB() {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event){
			if(this.totalFrames == this.currentFrame){
				this.stop();
			}
		}
	}
	
}
