package cocahappymachine.ui {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	internal class TabData {

		private var content:MovieClip;
		private var selectedButton:SimpleButton;
		private var unselectedButton:SimpleButton;
		
		public function TabData(content:MovieClip, selected:SimpleButton, unselected:SimpleButton) {
			this.content = content;
			this.selectedButton = selected;
			this.unselectedButton = unselected;
		}
		
		public function getContent():MovieClip{
			return content;
		}
		
		public function getSelected():SimpleButton{
			return selectedButton;
		}
		
		public function getUnselected():SimpleButton{
			return unselectedButton;
		}

	}
}