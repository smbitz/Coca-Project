package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import cocahappymachine.ui.BuildEvent;
	
	public class BuildPanel extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const BUILD:String = "BUILD";

		public var closeButton:MovieClip;
		
		public function BuildPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		//---- boxList is an array of BuildItemBox using for select item to build
		public function setBuildItemBox(boxList:Array){
			removeItemBox();
			var loop:int = 0;
			for each(var box:BuildItemBox in boxList){
				box.x = 20;
				box.y = loop * 50;
				if(box.getBuildable()){
					box.addEventListener(MouseEvent.CLICK, onItemBoxClick);
				}
				this.addChild(box);
				loop++;
			}
		}
		
		private function removeItemBox(){
			var itemBox:Array = new Array();
			for(var i:int = 0; i < this.numChildren; i++){
				if(this.getChildAt(i) is BuildItemBox){
					itemBox.push(this.getChildAt(i));
				}
			}
			for each(var box:BuildItemBox in itemBox){
				box.removeEventListener(MouseEvent.CLICK, onItemBoxClick);
				this.removeChild(box);
			}
		}
		
		public function onItemBoxClick(event:MouseEvent){
			var box:BuildItemBox = BuildItemBox(event.currentTarget);
			var buildingIdToBuild:String = box.getBuildingId();
			var bEvent:BuildEvent = new BuildEvent(BUILD);
			bEvent.setBuildingId(buildingIdToBuild);
			this.dispatchEvent(bEvent);
		}
	}
	
}
