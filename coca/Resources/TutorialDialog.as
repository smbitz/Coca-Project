package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class TutorialDialog extends MovieClip {
		
		public var closeButton:SimpleButton;
		public var backButton:SimpleButton;
		public var nextButton:SimpleButton;
		public var tutorialText:TextField;
		public var pageText:TextField;
		
		public function TutorialDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			backButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
			nextButton.addEventListener(MouseEvent.CLICK, onNextButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
		}
		
		public function onBackButtonClick(event:MouseEvent){
		}
		
		public function onNextButtonClick(event:MouseEvent){
		}
	}
	
}
