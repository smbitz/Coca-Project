package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.Event;
	
	
	public class TutorialDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const NEXT_BUTTON:String = "NEXT_BUTTON";
		public static const BACK_BUTTON:String = "BACK_BUTTON";
		
		public var closeButton:SimpleButton;
		public var backButton:SimpleButton;
		public var nextButton:SimpleButton;
		public var tutorialText:TextField;
		public var pageText:TextField;
		public var tutorialPage1:TutorialPage1;
		public var tutorialPage2:TutorialPage2;
		public var tutorialPage3:TutorialPage3;
		public var tutorialPage4:TutorialPage4;
		public var tutorialPage5:TutorialPage5;
		public var tutorialPage6:TutorialPage6;
		
		public function TutorialDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			backButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
			nextButton.addEventListener(MouseEvent.CLICK, onNextButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onBackButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(BACK_BUTTON));
		}
		
		public function onNextButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(NEXT_BUTTON));
		}
	}
	
}
