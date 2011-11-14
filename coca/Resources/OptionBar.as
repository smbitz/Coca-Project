package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.events.Event;
	
	
	public class OptionBar extends MovieClip {
		
		public static const OPEN:String = "OPEN";
		
		public var expandedMC:OptionBarExpand;
		public var button:SimpleButton;
		
		public function OptionBar() {
			expandedMC.visible = false;
			button.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(event:MouseEvent){
			expandedMC.visible = !expandedMC.visible;
			if(expandedMC.visible){
				this.dispatchEvent(new Event(OPEN));
			}
		}
		
		public function getExpaned():OptionBarExpand{
			return expandedMC;
		}
	}
	
}
