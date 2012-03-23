package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class AgreementDialog extends MovieClip {
		
		
		public var closeButton:SimpleButton;
		public var okButton:SimpleButton;
		public var checkboxOff:CheckBox;
		public var checkboxOn:CheckBoxOn;
		
		public function AgreementDialog() {
			okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);
			okButton.alpha = 0.5;
			checkboxOff.addEventListener(MouseEvent.CLICK, onCheckboxOffClick);
			checkboxOn.addEventListener(MouseEvent.CLICK, onCheckboxOnClick);
			checkboxOn.visible = false;
		}
		
		public function onOkButtonClick(event:MouseEvent){
			if(checkboxOn.visible == true){
				this.visible = false;
			}
		}
		
		public function onCheckboxOffClick(event:MouseEvent){
			checkboxOn.visible = true;
			checkboxOff.visible = false;
			okButton.alpha = 1;
		}
		
		public function onCheckboxOnClick(event:MouseEvent){
			checkboxOn.visible = false;
			checkboxOff.visible = true;
			okButton.alpha = 0.5;
		}
	}
	
}
