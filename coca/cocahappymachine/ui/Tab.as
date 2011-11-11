package cocahappymachine.ui {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class Tab extends MovieClip {

		private var tabList:Array;		// array of TabData which contain data of each tab
		private var currentTab:TabData;
		
		public function Tab() {
			tabList = new Array();
		}
		
		public function addTab(contentMC:MovieClip, selected:SimpleButton, unselected:SimpleButton){
			var t:TabData = new TabData(contentMC, selected, unselected);
			unselected.addEventListener(MouseEvent.CLICK, onTabClick);
			if(tabList.length == 0){
				currentTab = t;
			}
			tabList.push(t);
			calculate();
		}
		
		private function calculate(){
			for each(var t:TabData in tabList){
				if(t == currentTab){
					t.getContent().visible = true;
					t.getSelected().visible = true;
					t.getUnselected().visible = false;
				} else {
					t.getContent().visible = false;
					t.getSelected().visible = false;
					t.getUnselected().visible = true;
				}
			}
		}
		
		public function onTabClick(event:MouseEvent){
			trace("Tab Click");
			for each(var t:TabData in tabList){
				if(t.getUnselected() == event.target){
					currentTab = t;
					calculate();
				}
			}
		}

	}
	
}
