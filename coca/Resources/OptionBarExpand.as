package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class OptionBarExpand extends MovieClip {
				
		public static const SOUND_ON:String = "SOUND_ON";
		public static const SOUND_OFF:String = "SOUND_OFF";
		public static const ZOOM_IN:String = "ZOOM_IN";
		public static const ZOOM_OUT:String = "ZOOM_OUT";
		
		public var soundOn:SimpleButton;
		public var soundOff:SimpleButton;
		public var zoomIn:SimpleButton;
		public var zoomOut:SimpleButton;
		
		public function OptionBarExpand() {
			soundOn.addEventListener(MouseEvent.CLICK, onSoundOn);
			soundOff.addEventListener(MouseEvent.CLICK, onSoundOff);
			zoomIn.addEventListener(MouseEvent.CLICK, onZoomIn);
			zoomOut.addEventListener(MouseEvent.CLICK, onZoomOut);
		}
		
		public function setOption(isSoundOn:Boolean, isZoomInEnable:Boolean, isZoomOutEnable:Boolean){
			if(isSoundOn){
				soundOn.visible = true;
			} else {
				soundOff.visible = false;
			}
			if(isZoomInEnable){
				zoomIn.visible = true;
			} else {
				zoomIn.visible =false;
			}
			if(isZoomOutEnable){
				zoomOut.visible = true;
			} else {
				zoomOut.visible = false;
			}
		}
		
		public function onSoundOn(event:MouseEvent){
			this.dispatchEvent(new Event(SOUND_ON));
		}
		
		public function onSoundOff(event:MouseEvent){
			this.dispatchEvent(new Event(SOUND_OFF));			
		}
		
		public function onZoomIn(event:MouseEvent){
			this.dispatchEvent(new Event(ZOOM_IN));
		}
		
		public function onZoomOut(event:MouseEvent){
			this.dispatchEvent(new Event(ZOOM_OUT));
		}
	}
}