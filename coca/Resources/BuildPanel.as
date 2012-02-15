package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import cocahappymachine.ui.BuildEvent;
	import flash.display.SimpleButton;
	import cocahappymachine.ui.Paging;
	
	public class BuildPanel extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const BUILD:String = "BUILD";

		public var closeButton:SimpleButton;
		public var leftButton:SimpleButton;
		public var rightButton:SimpleButton;
		public var paging:MovieClip;
		public var bgMC:MovieClip;
		private var currentPage:int;
		
		public function BuildPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			currentPage = 0;
		}
		
		public function restoreCurrentPage(){
			Paging(paging.getChildAt(0)).setCurrentPage( currentPage );	
		}
		
		public function onEnterFrame(event:Event){
			if(this.totalFrames == this.currentFrame){
				this.stop();
			}
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			//reset paging
			currentPage = 0;
			
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		//---- boxList is an array of BuildItemBox using for select item to build
		public function setBuildItemBox(boxList:Array){
			removeItemBox();
			for each(var box:BuildItemBox in boxList){
				if(box.getBuildable()){
					box.addEventListener(MouseEvent.CLICK, onItemBoxClick);
				}
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
			}
		}
		
		public function onItemBoxClick(event:MouseEvent){
			currentPage = Paging(paging.getChildAt(0)).getCurrentPage();
			var box:BuildItemBox = BuildItemBox(event.currentTarget);
			var buildingIdToBuild:String = box.getBuildingId();
			var bEvent:BuildEvent = new BuildEvent(BUILD);
			bEvent.setBuildingId(buildingIdToBuild);
			this.dispatchEvent(bEvent);
		}
		
		public function setPaging(p:MovieClip){
			paging.addChild(p);
		}
		
		public function setCurrentPage(setPageValue:int){
			this.currentPage = setPageValue;
		}
		
		public function getCurrentPage():int{
			return currentPage;
		}
		
		public function getLeftButton():SimpleButton{
			return leftButton;
		}
		
		public function getRightButton():SimpleButton{
			return rightButton;
		}
	}
	
}
