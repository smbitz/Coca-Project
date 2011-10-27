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
	import Resources.SpecialCodeDialog;
	import Resources.CouponExchangeDialog;
	import Resources.BuildPanel;
	import Resources.AddItemPanel;
	import cocahappymachine.ui.AddItemEvent;
	import cocahappymachine.data.Tile;
	import cocahappymachine.data.Item;
	import Resources.OccupyDialog;
	import cocahappymachine.audio.AudioManager;
	
	public class GamePlay extends MovieClip{
		
		private var currentPlayer:Player;
		
		private var tutorialDialog:TutorialDialog;
		private var newspaperDialog:NewspaperDialog;
		private var specialCodeDialog:SpecialCodeDialog;
		private var couponExchangeDialog:CouponExchangeDialog;
		private var occupyDialog:OccupyDialog;
		private var buildPanel:BuildPanel;
		private var addItemPanel:AddItemPanel;
		
		private var farmMap:FarmMap;
		private var couponButton:CouponButton;
		private var specialCodeButton:SpecialCodeButton;
		private var moneyUI:MoneyUI;
		
		public function GamePlay() {
			currentPlayer = SystemConstructor.getInstance().getCurrentPlayer();
			//---- init interface ----
			//init FarmMap which consist of playTile, decorated area, market place
			farmMap = new FarmMap();
			farmMap.setCurrentPlayer(currentPlayer);
			farmMap.addEventListener(FarmMapEvent.TILE_PURCHASE, onTilePurchase);
			farmMap.addEventListener(FarmMapEvent.TILE_BUILD, onTileBuild);
			farmMap.addEventListener(FarmMapEvent.TILE_ADDITEM, onTileAddItem);
			farmMap.addEventListener(FarmMapEvent.TILE_HARVEST, onTileHarvest);
			farmMap.addEventListener(FarmMap.SHOP_CLICK, onShopClick);
			couponButton = new CouponButton();
			couponButton.addEventListener(MouseEvent.CLICK, onCouponButtonClick);
			couponButton.x = 400;
			couponButton.y = 50;
			specialCodeButton = new SpecialCodeButton();
			specialCodeButton.addEventListener(MouseEvent.CLICK, onSpecialCodeButtonClick);
			specialCodeButton.x = 400;
			specialCodeButton.y = 100;
			moneyUI = new MoneyUI();
			moneyUI.setMoney(currentPlayer.getMoney());
			moneyUI.x = 400;
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
			specialCodeDialog = new SpecialCodeDialog();
			specialCodeDialog.visible = false;
			specialCodeDialog.addEventListener(SpecialCodeDialog.DIALOG_CLOSE, onSpeicalCodeClose);
			specialCodeDialog.addEventListener(SpecialCodeDialog.DIALOG_CONFIRM, onSpecialCodeConfirm);
			this.addChild(specialCodeDialog);
			couponExchangeDialog = new CouponExchangeDialog();
			couponExchangeDialog.visible = false;
			couponExchangeDialog.addEventListener(CouponExchangeDialog.DIALOG_CLOSE, onCouponExchangeDialogClose);
			this.addChild(couponExchangeDialog);
			buildPanel = new BuildPanel();
			buildPanel.visible = false;
			buildPanel.addEventListener(BuildPanel.DIALOG_CLOSE, onBuildPanelClose);
			this.addChild(buildPanel);
			occupyDialog = new OccupyDialog();
			occupyDialog.visible = false;
			occupyDialog.addEventListener(OccupyDialog.DIALOG_CLOSE, onOccupyClose);
			occupyDialog.addEventListener(OccupyDialog.DIALOG_CONFIRM, onOccupyConfirm);
			this.addChild(occupyDialog);
			addItemPanel = new AddItemPanel();
			addItemPanel.visible = false;
			addItemPanel.addEventListener(AddItemPanel.DIALOG_CLOSE, onAddItemPanelClose);
			addItemPanel.addEventListener(AddItemPanel.SUPPLYITEM_CLICK, onSupplyItem);
			addItemPanel.addEventListener(AddItemPanel.EXTRAITEM1_CLICK, onExtraItem1);
			addItemPanel.addEventListener(AddItemPanel.EXTRAITEM2_CLICK, onExtraItem2);
			addItemPanel.addEventListener(AddItemPanel.MOVE_CLICK, onMoveBuilding);
			this.addChild(addItemPanel);
			//-------------------------
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

		private function setStateSpecialCode(){
			specialCodeDialog.visible = true;
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
		
		public function onTilePurchase(event:FarmMapEvent){
			occupyDialog.visible = true;
			//set data to occupyDialog
		}
		
		public function onTileBuild(event:FarmMapEvent){
			//display Build panel
			buildPanel.visible =true;
		}
		
		public function onTileAddItem(event:FarmMapEvent){
			addItemPanel.setTile(event.getClickedTile());
			addItemPanel.visible = true;
		}
		
		public function onTileHarvest(event:FarmMapEvent){
			//display harvaest animation
			currentPlayer.harvest(event.getClickedTile());
		}
		
		public function onShopClick(event:Event){
			trace("shop click");
			//display shop dialog
		}
		
		public function onCouponButtonClick(event:MouseEvent){
			couponExchangeDialog.visible = true;
		}
		
		public function onSpecialCodeButtonClick(event:MouseEvent){
			setStateSpecialCode();
		}
		
		public function onSpeicalCodeClose(event:Event){
			specialCodeDialog.visible = false;
		}
		
		public function onSpecialCodeConfirm(event:Event){
			specialCodeDialog.visible = false;
			//currentPlayer.exchange(itemId);
		}
		
		public function onCouponExchangeDialogClose(event:Event){
			couponExchangeDialog.visible = false;
		}
		
		public function onBuildPanelClose(event:Event){
			buildPanel.visible = false;
		}
		
		public function onAddItemPanelClose(event:Event){
			addItemPanel.visible = false;
		}
		
		public function onSupplyItem(event:AddItemEvent){
			currentPlayer.supplyItem(event.getClickedTile());
		}
		
		public function onExtraItem1(event:AddItemEvent){
			var t:Tile = event.getClickedTile();
			var i:Item = t.getBuilding().getExtraItem1();
			currentPlayer.extraItem(t, i);
		}
	
		public function onExtraItem2(event:AddItemEvent){
			var t:Tile = event.getClickedTile();
			var i:Item = t.getBuilding().getExtraItem2();
			currentPlayer.extraItem(t, i);
		}
		
		public function onMoveBuilding(event:AddItemEvent){
			trace("move");
			//start move state (allow player to select move destination tile
		}
		
		public function onOccupyClose(event:Event){
			occupyDialog.visible = false;
		}
		
		public function onOccupyConfirm(event:Event){
			occupyDialog.visible = false;
			//process occupy
		}
	}
}