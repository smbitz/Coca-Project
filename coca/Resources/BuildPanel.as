package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class BuildPanel extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";

		public var closeButton:MovieClip;
		
		public function BuildPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		//---- boxList is an array of BuildItemBox using for select item to build
		public function setBuildItemBox(boxList:Array){		
			//count boxList then create paging for all item in box list
			//add each item to panel
		}
		
		public function onItemBoxClick(event:MouseEvent){
			var box:BuildItemBox = BuildItemBox(event.currentTarget);
			var buildingIdToBuild:String = box.getBuildingId();
			//dispatchEvent build to continue building process
		}
	}
	
}
