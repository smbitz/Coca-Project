package cocahappymachine {
	import flash.display.MovieClip;
	import cocahappymachine.data.SystemConstructor;
	import cocahappymachine.data.Player;
	import Resources.TutorialDialog;
	import flash.events.Event;
	import Resources.NewspaperDialog;
	import cocahappymachine.util.Debug;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import cocahappymachine.util.GameTimer;
	import cocahappymachine.util.GameTimerEvent;
	import cocahappymachine.ui.FarmMap;
	import cocahappymachine.ui.FarmMapEvent;
	import Resources.CouponButton;
	import Resources.SpecialCodeButton;
	import flash.events.MouseEvent;
	import Resources.MoneyUI;
	
	public class GamePlay extends MovieClip{


		
		public static const STATE_TUTORIAL:int = 1;
		public static const STATE_NEWSPAPER:int = 2;
		public static const STATE_PLAY:int = 3;
		public static const STATE_SHOP:int = 4;
		
		private var currentPlayer:Player;
		
		private var tutorialDialog:TutorialDialog;
		private var newspaperDialog:NewspaperDialog;
		
		private var farmMap:FarmMap;
		private var couponButton:CouponButton;
		private var specialCodeButton:SpecialCodeButton;
		private var moneyUI:MoneyUI;
		
		public function GamePlay() {
			//---- init interface ----
			//init FarmMap which consist of playTile, decorated area, market place
			farmMap = new FarmMap();	//send tile data to farm map for construct map
			farmMap.addEventListener(FarmMapEvent.TILE_CLICK, onTileClick);
			couponButton = new CouponButton();
			couponButton.addEventListener(MouseEvent.CLICK, onCouponButtonClick);
			specialCodeButton = new SpecialCodeButton();
			specialCodeButton.addEventListener(MouseEvent.CLICK, onSpecialCodeButtonClick);
			moneyUI = new MoneyUI();
			this.addChild(farmMap);
			this.addChild(couponButton);
			this.addChild(specialCodeButton);
			this.addChild(moneyUI);
			//init interface LV, EXP, name, money, option bar, coupon button, special code button
			
			//---- init all dialog ----
			tutorialDialog = new TutorialDialog();
			tutorialDialog.visible = false;
			tutorialDialog.addEventListener(TutorialDialog.DIALOG_CLOSE, onTutorialClose);
			this.addChild(tutorialDialog);
			newspaperDialog = new NewspaperDialog();
			newspaperDialog.visible = false;
			newspaperDialog.addEventListener(NewspaperDialog.DIALOG_CLOSE, onNewspaperClose);
			this.addChild(newspaperDialog);
			//-------------------------
			currentPlayer = SystemConstructor.getInstance().getCurrentPlayer();
			if(currentPlayer.isNewGame()){
				setStateTutorial();
			} else {
				setStateNewspaper();		
			}
			//---- Start Game ----
			var t:GameTimer = new GameTimer();
			t.addEventListener(GameTimer.GAMETIMER_RUN, onRun);
			t.start();
		}
		
		private function setStateTutorial(){
			tutorialDialog.visible = true;
		}
		
		private function setStateNewspaper(){
			newspaperDialog.visible = true;
		}

		public function onTutorialClose(event:Event){
			tutorialDialog.visible = false;
			setStateNewspaper();
		}
		
		public function onNewspaperClose(event:Event){
			newspaperDialog.visible = false;
		}
		
		public function onRun(event:GameTimerEvent){
			currentPlayer.update(event.getElapse());
		}
		
		public function onTileClick(event:FarmMapEvent){
			trace("Tile Click - GamePlay.as");
			//check tile status
			//process as status
		}
		
		public function onCouponButtonClick(event:MouseEvent){
			
		}
		
		public function onSpecialCodeButtonClick(event:MouseEvent){
			
		}
	}
}