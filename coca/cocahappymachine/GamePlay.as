﻿package cocahappymachine {
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
	import cocahappymachine.data.Tile;
	import cocahappymachine.data.Item;
	import Resources.OccupyDialog;
	import cocahappymachine.audio.AudioManager;
	import cocahappymachine.ui.AbstractFarmTile;
	import cocahappymachine.data.Building;
	import Resources.BuildItemBox;
	import cocahappymachine.data.BuildingManager;
	import cocahappymachine.data.ItemManager;
	import cocahappymachine.ui.BuildEvent;
	import cocahappymachine.ui.FarmTileBuilder;
	import Resources.CouponExchangeItemBox2;
	import Resources.CouponExchangeItemBox1;
	import Resources.ShopDialog;
	import cocahappymachine.ui.CouponEvent;
	import cocahappymachine.data.ItemQuantityPair;
	import Resources.ShopBuyItemBox;
	import Resources.ShopSellItemBox;
	import flash.ui.Mouse;
	import Resources.MouseCursor;
	import Resources.StatusUI;
	import Resources.OptionBar;
	import Resources.LevelUpDialog;
	import Resources.GetItemDialog;
	import cocahappymachine.ui.ProgressBar;
	import Resources.ExpProgress;
	import cocahappymachine.ui.Paging;
	import cocahappymachine.ui.ShopEvent;
	import Resources.CouponExchangeTabContent;
	import cocahappymachine.data.ItemExchangeItem;
	import cocahappymachine.ui.AbstractCouponExchangeItemBox;
	import Resources.CouponExchangeItemBox3;
	import cocahappymachine.ui.Tab;
	import cocahappymachine.ui.ItemPictureBuilder;
	import Resources.CouponConfirmDialog;
	import Resources.CouponViewDialog;
	import cocahappymachine.ui.CodeViewEvent;
	import Resources.OptionBarExpand;
	import cocahappymachine.ui.BitmapFont;
	import cocahappymachine.ui.BigLevelBitmapConstructor;
	import cocahappymachine.ui.SmallLevelBitmapConstructor;
	import cocahappymachine.ui.TileUpdateEvent;
	import cocahappymachine.ui.ItemPairEvent;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import cocahappymachine.util.DragManager;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.IOErrorEvent
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.events.SecurityErrorEvent;
	import cocahappymachine.util.Config;
	import cocahappymachine.ui.Character;
	import Resources.AgreementDialog;


	public class GamePlay extends MovieClip{
		
		private static const PLAYSTATE_NORMAL:int = 1;
		private static const PLAYSTATE_MOVING:int = 2;
		
		private static const MOUSECURSOR_OFFSET_X:int = -5;
		private static const MOUSECURSOR_OFFSET_Y:int = -5;
		
		private static const OPTIONBAR_X:int = 680;
		private static const OPTIONBAR_Y:int = 15;
		private static const STATUSUI_X:int = 5;
		private static const STATUSUI_Y:int = 5;
		private static const MONEYUI_X:int = 250;
		private static const MONEYUI_Y:int = 15;
		private static const COUPONBUTTON_X:int = 600;
		private static const COUPONBUTTON_Y:int = 5;
		private static const SPECIALCODEBUTTON_X:int = 520;
		private static const SPECIALCODEBUTTON_Y:int = 15;
		
		private static const ADDITEMPANEL_POSITIONX_MIN:int = 170;
		private static const ADDITEMPANEL_POSITIONX_MAX:int = 590;
		private static const ADDITEMPANEL_POSITIONY_MIN:int = 220;
		private static const ADDITEMPANEL_POSITIONY_MAX:int = 550;
		
		private static const FIRST_TUTORIAL_1:int = 0;
		private static const FIRST_TUTORIAL_2:int = 1;
		private static const FIRST_TUTORIAL_3:int = 2;
		private static const FIRST_TUTORIAL_4:int = 3;
		private static const FIRST_TUTORIAL_5:int = 4;
		private static const FIRST_TUTORIAL_6:int = 5;
		
		private static const BUILDING_MORNING_GLORY_ID:String = "10";
		private static const BUILDING_CHINESE_CABBAGE_ID:String = "20";
		private static const BUILDING_PUMPKIN_ID:String = "30";
		private static const BUILDING_BABY_CORN_ID:String = "40";
		private static const BUILDING_STRAW_MUSHROOMS_ID:String = "50";
		private static const BUILDING_CHICKEN_ID:String = "60";
		private static const BUILDING_PIG_ID:String = "70";
		private static const BUILDING_COW_ID:String = "80";
		private static const BUILDING_SHEEP_ID:String = "90";
		private static const BUILDING_OSTRICH_ID:String = "100";
		
		private var currentPlayer:Player;
		
		private var tutorialDialog:TutorialDialog;
		private var newspaperDialog:NewspaperDialog;
		private var specialCodeDialog:SpecialCodeDialog;
		private var couponExchangeDialog:CouponExchangeDialog;
		private var occupyDialog:OccupyDialog;
		private var buildPanel:BuildPanel;
		private var addItemPanel:AddItemPanel;
		private var shopDialog:ShopDialog;
		private var levelUpDialog:LevelUpDialog;
		private var getItemDialog:GetItemDialog;
		private var couponConfirmDialog:CouponConfirmDialog;
		private var couponViewDialog:CouponViewDialog;
		private var agreementDialog:AgreementDialog;
		
		private var farmMap:FarmMap;
		private var activeTile:AbstractFarmTile;
		private var movingTile:AbstractFarmTile;
		private var couponButton:CouponButton;
		private var specialCodeButton:SpecialCodeButton;
		private var moneyUI:MoneyUI;
		private var statusUI:StatusUI;
		private var optionBar:OptionBar;
		private var playState:int;
		private var mouseCursor:MovieClip;
		private var expProgress:ProgressBar;
		private var buildPaging:Paging;
		private var sellPaging:Paging;
		private var buyPaging:Paging;
		private var couponExchangeAllCouponsTab:CouponExchangeTabContent;
		private var couponExchangeAvailableTab:CouponExchangeTabContent;
		private var couponExchangeUnavailableTab:CouponExchangeTabContent;
		private var couponExchangeMyCouponsTab:CouponExchangeTabContent;
		private var couponExchangePaging:Paging;
		private var couponExchangeAvailablePaging:Paging;
		private var couponExchangeUnavailablePaging:Paging;
		private var couponExchangeMyCouponsPaging:Paging;
		private var couponExchangeTab:Tab;
		private var bigLevelFont:BitmapFont;
		private var smallLevelFont:BitmapFont;
		
		private var currentTutorialPage:int;
		
		public function GamePlay(s:Stage) {
			currentPlayer = SystemConstructor.getInstance().getCurrentPlayer();
			currentPlayer.addEventListener(Player.LEVELUP, onLevelUp);
			currentPlayer.addEventListener(Player.UPDATE_EXP, onUpdateExp);
			currentPlayer.addEventListener(Player.SPECIAL_CODE_FAIL, onSpecialCodeFail);
			currentPlayer.addEventListener(Player.SPECIAL_CODE_SUCCESS, onSpecialCodeSuccess);
			currentPlayer.addEventListener(Player.CODE_RECEIVE, onCodeReceive);
			currentPlayer.addEventListener(Player.ITEM_UPDATE, onItemUpdate);
			currentPlayer.addEventListener(Player.EXCHANGE_SUCCESS, onExchangeSuccess);
			currentPlayer.addEventListener(TileUpdateEvent.TILE_UPDATE, onTileUpdate);
			mouseCursor = new MouseCursor();
			mouseCursor.mouseEnabled = false;
			Mouse.hide();
			
			
			currentTutorialPage = FIRST_TUTORIAL_1;
			
			//---- init interface ----
			bigLevelFont = new BitmapFont(new BigLevelBitmapConstructor());
			smallLevelFont = new BitmapFont(new SmallLevelBitmapConstructor());
			
			//init FarmMap which consist of playTile, decorated area, market place
			farmMap = new FarmMap(s);
			farmMap.setCurrentPlayer(currentPlayer);
			
			couponButton = new CouponButton();
			couponButton.addEventListener(MouseEvent.CLICK, onCouponButtonClick);
			couponButton.x = COUPONBUTTON_X;
			couponButton.y = COUPONBUTTON_Y;
			
			specialCodeButton = new SpecialCodeButton();
			specialCodeButton.addEventListener(MouseEvent.CLICK, onSpecialCodeButtonClick);
			specialCodeButton.x = SPECIALCODEBUTTON_X;
			specialCodeButton.y = SPECIALCODEBUTTON_Y;
			
			moneyUI = new MoneyUI();
			moneyUI.setMoney(currentPlayer.getMoney());
			moneyUI.x = MONEYUI_X;
			moneyUI.y = MONEYUI_Y;
			statusUI = new StatusUI();
			statusUI.x = STATUSUI_X;
			statusUI.y = STATUSUI_Y;
			statusUI.setName(currentPlayer.getName());
			statusUI.setNumberMC(smallLevelFont.getMovieClip(currentPlayer.getLevel().toString(), 
							BitmapFont.H_CENTER | BitmapFont.TOP));
			expProgress = new ProgressBar();
			var progressMC:ExpProgress = new ExpProgress();
			expProgress.setMC(progressMC);
			expProgress.setSize(115);
			expProgress.setProgress(currentPlayer.getExpProgress());
			statusUI.setProgressMC(expProgress);
			optionBar = new OptionBar();
			optionBar.addEventListener(OptionBar.OPEN, onOptionBarOpen);
			optionBar.addEventListener(OptionBar.CLICK, onOptionBarClick);
			var expanded:OptionBarExpand = optionBar.getExpaned();
			expanded.addEventListener(OptionBarExpand.SOUND_ON, onSoundOn);
			expanded.addEventListener(OptionBarExpand.SOUND_OFF, onSoundOff);
			expanded.addEventListener(OptionBarExpand.ZOOM_IN, onZoomIn);
			expanded.addEventListener(OptionBarExpand.ZOOM_OUT, onZoomOut);
			optionBar.x = OPTIONBAR_X;
			optionBar.y = OPTIONBAR_Y;
			this.addChild(farmMap);
			this.addChild(couponButton);
			this.addChild(specialCodeButton);
			this.addChild(moneyUI);
			this.addChild(statusUI);
			this.addChild(optionBar);
			
			//---- init all dialog ----
			tutorialDialog = new TutorialDialog();
			tutorialDialog.visible = false;
			tutorialDialog.addEventListener(TutorialDialog.DIALOG_CLOSE, onTutorialClose);
			tutorialDialog.addEventListener(TutorialDialog.NEXT_BUTTON, onNextButtonClick);
			tutorialDialog.addEventListener(TutorialDialog.BACK_BUTTON, onBackButtonClick);
			this.addChild(tutorialDialog);
			
			newspaperDialog = new NewspaperDialog();

			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onNewspaperComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onNewspaperError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onNewspaperSecurityError);
			var url:String = Config.getInstance().getData("NEWSPAPER_URL");
			urlLoader.load(new URLRequest(url));
			newspaperDialog.visible = false;
			newspaperDialog.addEventListener(NewspaperDialog.DIALOG_CLOSE, onNewspaperClose);
			
			var urlLoaderPage2:URLLoader = new URLLoader();
			urlLoaderPage2.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoaderPage2.addEventListener(Event.COMPLETE, onNewspaperPage2Complete);
			urlLoaderPage2.addEventListener(IOErrorEvent.IO_ERROR, onNewspaperError);
			urlLoaderPage2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onNewspaperSecurityError);
			var urlPage2:String = Config.getInstance().getData("NEWSPAPER_URL_PAGE_2");
			urlLoaderPage2.load(new URLRequest(urlPage2));
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
			couponExchangeDialog.addEventListener(CouponExchangeDialog.VIEW_CODE, onCouponExchangeViewCode);
			couponExchangeDialog.addEventListener(CouponExchangeDialog.EXCHANGE, onCouponExchangeExchange);
			couponExchangeAllCouponsTab = new CouponExchangeTabContent();
			couponExchangeDialog.addTabContent(couponExchangeAllCouponsTab);
			couponExchangeAvailableTab = new CouponExchangeTabContent();
			couponExchangeDialog.addTabContent(couponExchangeAvailableTab);
			couponExchangeUnavailableTab = new CouponExchangeTabContent();
			couponExchangeDialog.addTabContent(couponExchangeUnavailableTab);
			couponExchangeMyCouponsTab = new CouponExchangeTabContent();
			couponExchangeDialog.addTabContent(couponExchangeMyCouponsTab);
			couponExchangePaging = new Paging();
			couponExchangePaging.setGap(280, 130);
			couponExchangePaging.setItemPerPage(2, 3);
			couponExchangePaging.setLeftRightButton(couponExchangeAllCouponsTab.getLeftButton(), 
													couponExchangeAllCouponsTab.getRightButton());
			couponExchangeAllCouponsTab.setPaging(couponExchangePaging);
			couponExchangeAvailablePaging = new Paging();
			couponExchangeAvailablePaging.setGap(280, 130);
			couponExchangeAvailablePaging.setItemPerPage(2, 3);
			couponExchangeAvailablePaging.setLeftRightButton(
										couponExchangeAvailableTab.getLeftButton(), 
										couponExchangeAvailableTab.getRightButton());
			couponExchangeAvailableTab.setPaging(couponExchangeAvailablePaging);
			couponExchangeUnavailablePaging = new Paging();
			couponExchangeUnavailablePaging.setGap(280, 130);
			couponExchangeUnavailablePaging.setItemPerPage(2, 3);
			couponExchangeUnavailablePaging.setLeftRightButton(
										couponExchangeUnavailableTab.getLeftButton(), 
										couponExchangeUnavailableTab.getRightButton());
			couponExchangeAllCouponsTab.setPaging(couponExchangePaging);
			couponExchangeUnavailableTab.setPaging(couponExchangeUnavailablePaging);
			couponExchangeMyCouponsPaging = new Paging();
			couponExchangeMyCouponsPaging.setGap(280, 130);
			couponExchangeMyCouponsPaging.setItemPerPage(2, 3);
			couponExchangeMyCouponsPaging.setLeftRightButton(
										couponExchangeMyCouponsTab.getLeftButton(), 
										couponExchangeMyCouponsTab.getRightButton());
			couponExchangeMyCouponsTab.setPaging(couponExchangeMyCouponsPaging);
			couponExchangeTab = new Tab();
			couponExchangeTab.addTab(couponExchangeAllCouponsTab, 
									 couponExchangeDialog.getAllCouponsSelectedButton(), 
									 couponExchangeDialog.getAllCouponUnselectedButton());
			couponExchangeTab.addTab(couponExchangeAvailableTab, 
									 couponExchangeDialog.getAvailableSelectedButton(), 
									 couponExchangeDialog.getAvailableUnselectedButton());
			couponExchangeTab.addTab(couponExchangeUnavailableTab, 
									 couponExchangeDialog.getUnavailableSelectedButton(), 
									 couponExchangeDialog.getUnavailableUnselectedButton());
			couponExchangeTab.addTab(couponExchangeMyCouponsTab, 
									 couponExchangeDialog.getMyCouponsSelectedButton(), 
									 couponExchangeDialog.getMyCouponsUnselectedButton());
			this.addChild(couponExchangeDialog);
			buildPanel = new BuildPanel();
			buildPanel.visible = false;
			buildPanel.addEventListener(BuildPanel.DIALOG_CLOSE, onBuildPanelClose);
			buildPanel.addEventListener(BuildPanel.BUILD, onBuildPanelBuild);
			buildPaging = new Paging();
			buildPaging.setLeftRightButton(buildPanel.getLeftButton(), buildPanel.getRightButton());
			buildPanel.setPaging(buildPaging);
			buildPaging.setGap(90, 150);
			buildPaging.setItemPerPage(7, 1);
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
			shopDialog = new ShopDialog();
			shopDialog.addEventListener(ShopDialog.DIALOG_CLOSE, onShopDialogClose);
			shopDialog.addEventListener(ShopDialog.BUY, onShopDialogBuy);
			shopDialog.addEventListener(ShopDialog.SELL, onShopDialogSell);
			sellPaging = new Paging();
			sellPaging.setGap(115, 200);
			sellPaging.setItemPerPage(5, 1);
			sellPaging.setLeftRightButton(shopDialog.getSellLeftButton(), shopDialog.getSellRightButton());
			shopDialog.setSellPaging(sellPaging);
			buyPaging = new Paging();
			buyPaging.setGap(115, 200);
			buyPaging.setItemPerPage(5, 1);
			buyPaging.setLeftRightButton(shopDialog.getBuyLeftButton(), shopDialog.getBuyRightButton());
			shopDialog.setBuyPaging(buyPaging);
			shopDialog.visible = false;
			this.addChild(shopDialog);
			levelUpDialog = new LevelUpDialog();
			levelUpDialog.addEventListener(LevelUpDialog.DIALOG_CLOSE, onLevelUpDialogClose);
			levelUpDialog.visible = false;
			this.addChild(levelUpDialog);
			getItemDialog = new GetItemDialog();
			getItemDialog.addEventListener(GetItemDialog.DIALOG_CLOSE, onGetItemDialogClose);
			getItemDialog.visible = false;
			this.addChild(getItemDialog);
			couponConfirmDialog = new CouponConfirmDialog();
			couponConfirmDialog.addEventListener(CouponConfirmDialog.DIALOG_CLOSE, onCouponConfirmClose);
			couponConfirmDialog.addEventListener(CouponConfirmDialog.DIALOG_CONFIRM, onCouponConfirmConfirm);
			couponConfirmDialog.visible =false;
			this.addChild(couponConfirmDialog);
			couponViewDialog = new CouponViewDialog();
			couponViewDialog.addEventListener(CouponViewDialog.DIALOG_CLOSE, onCouponViewClose);
			couponViewDialog.visible = false;
			this.addChild(couponViewDialog);
			
			if(currentPlayer.isNewGame()){
				agreementDialog = new AgreementDialog();
				agreementDialog.visible = true;
				agreementDialog.x = 40;
				this.addChild(agreementDialog);				
			}
			
			
			//-------------------------
			if(currentPlayer.isNewGame()){
				setStateTutorial();
			} else {
				setStateNewspaper();		
			}
			//---- Start Game ----
			setPlayStateNormal();
			var t:GameTimer = new GameTimer();
			t.addEventListener(GameTimer.GAMETIMER_RUN, onRun);
			t.start();
			
			AudioManager.getInstance().playBG("MUSIC_BG");
			this.addChild(mouseCursor);
		}
		
		private function setPlayStateNormal(){
			playState = PLAYSTATE_NORMAL;
			if(movingTile != null){
				this.removeChild(movingTile);
			}
			farmMap.addEventListener(FarmMapEvent.TILE_PURCHASE, onTilePurchase);
			farmMap.addEventListener(FarmMapEvent.TILE_BUILD, onTileBuild);
			farmMap.addEventListener(FarmMapEvent.TILE_ADDITEM, onTileAddItem);
			farmMap.addEventListener(FarmMapEvent.TILE_HARVEST, onTileHarvest);
			farmMap.addEventListener(FarmMapEvent.TILE_SHOTCUTSUPPLY, onTileShotcutSupply);
			farmMap.addEventListener(FarmMap.SHOP_CLICK, onShopClick);
			farmMap.removeEventListener(FarmMapEvent.MOVE_DESTINATION, onMoveDestination);
		}
		
		private function setPlayStateMoving(){
			playState = PLAYSTATE_MOVING;
			movingTile = FarmTileBuilder.createFarmTile(activeTile.getData());
			movingTile.alpha = 0.7;
			this.addChild(movingTile);
			farmMap.addEventListener(FarmMapEvent.MOVE_DESTINATION, onMoveDestination);
			farmMap.removeEventListener(FarmMapEvent.TILE_PURCHASE, onTilePurchase);
			farmMap.removeEventListener(FarmMapEvent.TILE_BUILD, onTileBuild);
			farmMap.removeEventListener(FarmMapEvent.TILE_ADDITEM, onTileAddItem);
			farmMap.removeEventListener(FarmMapEvent.TILE_HARVEST, onTileHarvest);
			farmMap.removeEventListener(FarmMap.SHOP_CLICK, onShopClick);
			
		}
		
		private function setStateTutorial(){
			tutorialDialog.visible = true;
		}
		
		private function setStateNewspaper(){
			newspaperDialog.visible = true;
		}

		private function setStateSpecialCode(){
			specialCodeDialog.visible = true;
			specialCodeDialog.setMessage(false);
		}
		
		public function onTutorialClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			tutorialDialog.visible = false;
			setStateNewspaper();
		}
		
		public function onNextButtonClick(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			switch(currentTutorialPage){
				case FIRST_TUTORIAL_1:
				tutorialDialog.tutorialPage1.visible = false;
				tutorialDialog.pageNumber1.visible = false;
				tutorialDialog.tutorialPage2.visible = true;
				tutorialDialog.pageNumber2.visible = true;
				tutorialDialog.backButton.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_2;
					break;
				case FIRST_TUTORIAL_2:
				tutorialDialog.tutorialPage2.visible = false;
				tutorialDialog.pageNumber2.visible = false;
				tutorialDialog.tutorialPage3.visible = true;
				tutorialDialog.pageNumber3.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_3;
					break;
				case FIRST_TUTORIAL_3:
				tutorialDialog.tutorialPage3.visible = false;
				tutorialDialog.pageNumber3.visible = false;
				tutorialDialog.tutorialPage4.visible = true;
				tutorialDialog.pageNumber4.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_4;
					break;
				case FIRST_TUTORIAL_4:
				tutorialDialog.tutorialPage4.visible = false;
				tutorialDialog.pageNumber4.visible = false;
				tutorialDialog.tutorialPage5.visible = true;
				tutorialDialog.pageNumber5.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_5;
					break;
				case FIRST_TUTORIAL_5:
				tutorialDialog.tutorialPage5.visible = false;
				tutorialDialog.pageNumber5.visible = false;
				tutorialDialog.tutorialPage6.visible = true;
				tutorialDialog.pageNumber6.visible = true;
				tutorialDialog.nextButton.visible = false;
				currentTutorialPage = FIRST_TUTORIAL_6;
					break;
			}
		}
		
		public function onBackButtonClick(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			switch(currentTutorialPage){
				case FIRST_TUTORIAL_6:
				tutorialDialog.tutorialPage6.visible = false;
				tutorialDialog.pageNumber6.visible = false;
				tutorialDialog.tutorialPage5.visible = true;
				tutorialDialog.pageNumber5.visible = true;
				tutorialDialog.nextButton.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_5;
					break;
				case FIRST_TUTORIAL_5:
				tutorialDialog.tutorialPage5.visible = false;
				tutorialDialog.pageNumber5.visible = false;
				tutorialDialog.tutorialPage4.visible = true;
				tutorialDialog.pageNumber4.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_4;
					break;
				case FIRST_TUTORIAL_4:
				tutorialDialog.tutorialPage4.visible = false;
				tutorialDialog.pageNumber4.visible = false;
				tutorialDialog.tutorialPage3.visible = true;
				tutorialDialog.pageNumber3.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_3;
					break;
				case FIRST_TUTORIAL_3:
				tutorialDialog.tutorialPage3.visible = false;
				tutorialDialog.pageNumber3.visible = false;
				tutorialDialog.tutorialPage2.visible = true;
				tutorialDialog.pageNumber2.visible = true;
				currentTutorialPage = FIRST_TUTORIAL_2;
					break;
				case FIRST_TUTORIAL_2:
				tutorialDialog.tutorialPage2.visible = false;
				tutorialDialog.pageNumber2.visible = false;
				tutorialDialog.tutorialPage1.visible = true;
				tutorialDialog.pageNumber1.visible = true;
				tutorialDialog.backButton.visible = false;
				currentTutorialPage = FIRST_TUTORIAL_1;
					break;
			}
		}
		
		public function onNewspaperClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			newspaperDialog.visible = false;
		}
		
		public function onRun(event:GameTimerEvent){
			mouseCursor.x = this.mouseX + MOUSECURSOR_OFFSET_X;
			mouseCursor.y = this.mouseY + MOUSECURSOR_OFFSET_Y;
			currentPlayer.update(event.getElapse());
			moneyUI.setMoney(currentPlayer.getMoney());
			if(playState == PLAYSTATE_MOVING){
				movingTile.x = this.mouseX;
				movingTile.y = this.mouseY;
			}
			if(addItemPanel.visible){
				addItemPanel.setProgress(activeTile.getData().getProgress());
				addItemPanel.setSupply(activeTile.getData().getSupplyPercentage());
			}
		}
		
		public function onTilePurchase(event:FarmMapEvent){
			AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
			
			activeTile = event.getClickedTile();
			occupyDialog.visible = true;
			var level:int = currentPlayer.getLevelRequiredForPurchaseTile();
			var money:int = currentPlayer.getMoneyRequiredForPurchaseTile();
			var isLevelEnough:Boolean = false;
			var isMoneyEnough:Boolean = false;
			if(level <= currentPlayer.getLevel()){
				isLevelEnough = true;
			}
			if(money <= currentPlayer.getMoney()){
				isMoneyEnough = true;
			}
			occupyDialog.setData(level, money.toString(), isLevelEnough, isMoneyEnough);
		}
		
		public function onTileBuild(event:FarmMapEvent){
			AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
			
			activeTile = event.getClickedTile();
			buildPanel.visible =true;
			buildPanel.gotoAndPlay(0);
			var tile:Tile = event.getClickedTile().getData();
			var buildingList:Array = BuildingManager.getInstance().getBuildingForLandType(tile.getLandType());
			var itemBox:Array = createBuildItemBox(buildingList);
			buildPanel.setBuildItemBox(itemBox);
			buildPaging.setItem(itemBox);
			buildPaging.setCurrentPage(0);
			//Filter land type sea.
			if( tile.getLandType()==Tile.LAND_TYPE_SEA ){
				if(buildPaging.getMaxPage()<buildPanel.getCurrentPage()){
					buildPanel.setCurrentPage(buildPaging.getMaxPage()-1);
				}else{
					buildPanel.restoreCurrentPage();
				}
			}else{
				buildPanel.restoreCurrentPage();
			}
		}
		
		public function createBuildItemBox(buildingArray:Array):Array{
			var boxArray:Array = new Array();
			for each(var building:Building in buildingArray){
				var box:BuildItemBox = new BuildItemBox();
				box.setBuildingId(building.getId());
				box.setTitle(building.getName());
				box.setDuration(building.getBuildPeriod());
				box.setPicture(ItemPictureBuilder.createBuildItemBoxPicture(building));
				var isEnoughMoney:Boolean = true;
				if(building.getBuildItem().getPrice() > currentPlayer.getMoney()){
					isEnoughMoney = false;
				}
				box.setPrice(building.getBuildItem().getPrice(), 
							 currentPlayer.getItemQuantity(building.getBuildItem()), isEnoughMoney);
				boxArray.push(box);
			}
			return boxArray;
		}
		
		public function onTileAddItem(event:FarmMapEvent){
			AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
			
			activeTile = event.getClickedTile();
			var isSupply:Boolean = currentPlayer.isAllowToSupply(activeTile.getData());
			var isExtra1:Boolean = currentPlayer.isAllowToExtra1(activeTile.getData());
			var isExtra2:Boolean = currentPlayer.isAllowToExtra2(activeTile.getData());
			var building:Building = activeTile.getData().getBuilding();
			addItemPanel.visible = true;
			addItemPanel.setName(building.getName());
			addItemPanel.x = Math.min(this.mouseX, ADDITEMPANEL_POSITIONX_MAX);
			addItemPanel.x = Math.max(addItemPanel.x, ADDITEMPANEL_POSITIONX_MIN);
			addItemPanel.y = Math.min(this.mouseY, ADDITEMPANEL_POSITIONY_MAX);
			addItemPanel.y = Math.max(addItemPanel.y, ADDITEMPANEL_POSITIONY_MIN);
			addItemPanel.setProgress(activeTile.getData().getProgress());
			addItemPanel.setSupply(activeTile.getData().getSupplyPercentage());
			addItemPanel.setPicture(ItemPictureBuilder.createAddItemBoxPicture(building));
			addItemPanel.setSmallPicture(ItemPictureBuilder.createAddItemSmallPicture(building));
			addItemPanel.setSupplyButton(ItemPictureBuilder.createAddItemSupplyButton(building, isSupply), isSupply);
			addItemPanel.setExtra1Button(ItemPictureBuilder.createAddItemExtra1Button(building, isExtra1), isExtra1);
			addItemPanel.setExtra2Button(ItemPictureBuilder.createAddItemExtra2Button(building, isExtra2), isExtra2);
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			
			currentPlayer.updateToServer( tileToSave, null );
		}
		
		public function onTileHarvest(event:FarmMapEvent){
			AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
			
			activeTile = event.getClickedTile();
			var receiveItem:Array = currentPlayer.harvest(event.getClickedTile().getData());	//array of ItemQuantityPair
			var mcArray:Array = new Array();
			for each(var itemPair:ItemQuantityPair in receiveItem){
				mcArray.push(ItemPictureBuilder.createPopItem(itemPair.getItem().getId()));
			}
			farmMap.setPopItem(activeTile, mcArray);
			farmMap.updateTile(event.getClickedTile());
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( event.getClickedTile().getData() );
			
			//Add item to save data
			var itemToSave:Array = new Array();
			for each(  var updateItem:ItemQuantityPair in receiveItem ){
				itemToSave.push( updateItem.getItem() );
			}
			
			currentPlayer.updateToServer( tileToSave, itemToSave );
		}
		
		public function onShopClick(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_BUTTON_CLICK");
			
			if(!DragManager.getInstance().isDragging()){
				shopDialog.visible = true;
				shopDialog.gotoAndPlay(0);
				var buyItem:Array = ItemManager.getInstance().getItemByType("normal");	//array of item
				var sellItem:Array = currentPlayer.getSellableItem();					//array of ItemQuantityPair
				var buyBoxList:Array = new Array();
				var sellBoxList:Array = new Array();
				//Add Tab 1
				for each(var item:Item in buyItem){
					var buyBox:ShopBuyItemBox = new ShopBuyItemBox();
					buyBox.setItemId(item.getId());
					buyBox.setPicture(ItemPictureBuilder.createShopItemBoxPicture(item));
					var isEnoughMoney:Boolean = true;
					if(currentPlayer.getMoney() < item.getPrice()){
						isEnoughMoney = false;
					}
					buyBox.setPrice(item.getPrice(), isEnoughMoney);
					buyBox.setName(item.getName());
					var building:Building = BuildingManager.getInstance().getBuildingByBuildItem(item);
					if(building != null){
						buyBox.setTime(building.getBuildPeriod());
					} else {
						buyBox.setTime(0);
					}
					buyBoxList.push(buyBox);
				}
				
				//Sort Sell Item
				sellItem.sort(sortOnItemId);
				
				for each(var backpack:ItemQuantityPair in sellItem){
					var sellBox:ShopSellItemBox = new ShopSellItemBox();
					sellBox.setPicture(ItemPictureBuilder.createShopItemBoxPicture(backpack.getItem()));
					sellBoxList.push(sellBox);
					sellBox.setItemId(backpack.getItem().getId());
					sellBox.setName(backpack.getItem().getName());
					sellBox.setQuantity(backpack.getItemQty());
					sellBox.setPrice(backpack.getItem().getSellPrice());
				}
				sellPaging.setItem(sellBoxList);
				sellPaging.setCurrentPage(0);
				buyPaging.setItem(buyBoxList);
				buyPaging.setCurrentPage(0);
				shopDialog.setBuyItemBox(buyBoxList);
				shopDialog.setSellItemBox(sellBoxList);
				shopDialog.restoreCurrentPage();
			}
		}
		
		public function sortOnItemId(a:ItemQuantityPair,b:ItemQuantityPair):Number{
			var aItemId:Number = Number(a.getItemId());
			var bItemId:Number = Number(b.getItemId());
		
			if(aItemId > bItemId) {
				return 1;
			} else if(aItemId < bItemId) {
				return -1;
			} else  {
				return 0;
			}
		}
		
		public function onCouponButtonClick(event:MouseEvent){
			AudioManager.getInstance().playEffect("EFFECT_BUTTON_CLICK");
			
			couponExchangeDialog.visible = true;
			couponExchangeDialog.gotoAndPlay(0);
			var itemBoxList:Array = new Array();
			var availableBoxList:Array = new Array();
			var unavailableBoxList:Array = new Array();
			var myCouponsBoxList:Array = new Array();
			var couponItemList:Array = ItemManager.getInstance().getItemByType("coupon");
			for each(var item:Item in couponItemList){
				var box:AbstractCouponExchangeItemBox;
				if(currentPlayer.isItemEnough(item.getId(), 1)){
					box = new CouponExchangeItemBox3();
					box.setItemId(item.getId());
					box.setName(item.getName());
					box.setPicture(ItemPictureBuilder.createCouponExchangeItemBox3Picture(item));
					var myBox:AbstractCouponExchangeItemBox = new CouponExchangeItemBox3();
					myBox.setName(item.getName());
					myBox.setItemId(item.getId());
					myBox.setPicture(ItemPictureBuilder.createCouponExchangeItemBox3Picture(item));
					myCouponsBoxList.push(myBox);
				} else {
					var i:ItemExchangeItem = item.getExchangeItem()[0];
					if(currentPlayer.isItemEnough(i.getItem().getId(), i.getQuantity())){
						box = new CouponExchangeItemBox2();
						box.setItemId(item.getId());
						box.setName(item.getName());
						box.setItemQuantity(currentPlayer.getItemQuantity(i.getItem()));
						box.setItemRequire(i.getQuantity());
						box.setPicture(ItemPictureBuilder.createCouponExchangeItemBox2Picture(item));
						var availableBox:AbstractCouponExchangeItemBox = new CouponExchangeItemBox2();
						availableBox.setItemId(item.getId());
						availableBox.setName(item.getName());
						availableBox.setItemQuantity(currentPlayer.getItemQuantity(i.getItem()));
						availableBox.setItemRequire(i.getQuantity());
						availableBox.setPicture(ItemPictureBuilder.createCouponExchangeItemBox2Picture(item));
						availableBoxList.push(availableBox);
					} else {
						box = new CouponExchangeItemBox1();
						box.setItemId(item.getId());
						box.setName(item.getName());
						box.setItemQuantity(currentPlayer.getItemQuantity(i.getItem()));
						box.setItemRequire(i.getQuantity());
						box.setPicture(ItemPictureBuilder.createCouponExchangeItemBox1Picture(item));
						var unavailableBox:AbstractCouponExchangeItemBox = new CouponExchangeItemBox1();
						unavailableBox.setItemId(item.getId());
						unavailableBox.setName(item.getName());
						unavailableBox.setItemQuantity(currentPlayer.getItemQuantity(i.getItem()));
						unavailableBox.setItemRequire(i.getQuantity());
						unavailableBox.setPicture(ItemPictureBuilder.createCouponExchangeItemBox1Picture(item));
						unavailableBoxList.push(unavailableBox);
					}
				}
				itemBoxList.push(box);
			}
			
			var allArray:Array = new Array();
			allArray = allArray.concat(itemBoxList);
			allArray = allArray.concat(availableBoxList);
			allArray = allArray.concat(unavailableBoxList);
			allArray = allArray.concat(myCouponsBoxList);
			couponExchangePaging.setItem(itemBoxList);
			couponExchangeAvailablePaging.setItem(availableBoxList);
			couponExchangeUnavailablePaging.setItem(unavailableBoxList);
			couponExchangeMyCouponsPaging.setItem(myCouponsBoxList);
			couponExchangeDialog.setItemBox(allArray);
		}
		
		public function onSpecialCodeButtonClick(event:MouseEvent){
			AudioManager.getInstance().playEffect("EFFECT_BUTTON_CLICK");
			setStateSpecialCode();
		}
		
		public function onSpeicalCodeClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			specialCodeDialog.visible = false;
		}
		
		public function onSpecialCodeConfirm(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			specialCodeDialog.visible = false;
			currentPlayer.specialCodeInput(specialCodeDialog.getCode());
		}
		
		public function onCouponExchangeDialogClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			couponExchangeDialog.visible = false;
		}
		
		public function onBuildPanelClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			buildPanel.visible = false;
		}
		
		public function onAddItemPanelClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			addItemPanel.visible = false;
		}
		
		public function onTileShotcutSupply(event:FarmMapEvent){
			activeTile = event.getClickedTile();
			onSupplyItem(null);
		}
		
		public function onSupplyItem(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			addItemPanel.visible = false;
			currentPlayer.supplyItem(activeTile.getData());
			
			// check condition on tile type, supplyAction only for vege tile
			if( activeTile.getData().getBuildingId() == BUILDING_MORNING_GLORY_ID ||
			    activeTile.getData().getBuildingId() == BUILDING_CHINESE_CABBAGE_ID ||
				activeTile.getData().getBuildingId() == BUILDING_PUMPKIN_ID ||
				activeTile.getData().getBuildingId() == BUILDING_BABY_CORN_ID ||
				activeTile.getData().getBuildingId() == BUILDING_STRAW_MUSHROOMS_ID ||
				activeTile.getData().getBuildingId() == BUILDING_CHICKEN_ID ||
				activeTile.getData().getBuildingId() == BUILDING_PIG_ID ||
				activeTile.getData().getBuildingId() == BUILDING_COW_ID ||
				activeTile.getData().getBuildingId() == BUILDING_SHEEP_ID ||
				activeTile.getData().getBuildingId() == BUILDING_OSTRICH_ID ){
				farmMap.getCharacter().supplyAction(activeTile);
			}
				
			farmMap.updateTile(activeTile);
			var t:AbstractFarmTile = farmMap.getFarmTile(activeTile.getData());
			t.setAddTile(ItemPictureBuilder.createAddTile(activeTile.getData().getBuilding().getSupplyId()));
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			
			//Add item to save data
			var itemToSave:Array = new Array();
			itemToSave.push( activeTile.getData().getBuilding().getSupplyItem() );
			
			currentPlayer.updateToServer( tileToSave, itemToSave );
		}
		
		public function onExtraItem1(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem1();
			currentPlayer.extraItem(activeTile.getData(), i);
			farmMap.updateTile(activeTile);
			var t:AbstractFarmTile = farmMap.getFarmTile(activeTile.getData());
			t.setAddTile(ItemPictureBuilder.createAddTile(activeTile.getData().getBuilding().getExtraItem1().getId()));
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			
			//Add item to save data
			var itemToSave:Array = new Array();
			itemToSave.push( activeTile.getData().getBuilding().getExtraItem1() );
			
			currentPlayer.updateToServer( tileToSave, itemToSave );
		}
	
		public function onExtraItem2(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem2();
			currentPlayer.extraItem(activeTile.getData(), i);
			farmMap.updateTile(activeTile);
			var t:AbstractFarmTile = farmMap.getFarmTile(activeTile.getData());
			t.setAddTile(ItemPictureBuilder.createAddTile(activeTile.getData().getBuilding().getExtraItem2().getId()));
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			
			//Add item to save data
			var itemToSave:Array = new Array();
			itemToSave.push( activeTile.getData().getBuilding().getExtraItem2() );
			
			currentPlayer.updateToServer( tileToSave, itemToSave );
		}
		
		public function onMoveBuilding(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			trace("move");
			addItemPanel.visible = false;
			setPlayStateMoving();
			currentPlayer.updateToServer( null, null );
		}
		
		public function onOccupyClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			occupyDialog.visible = false;
		}
		
		public function onOccupyConfirm(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_COIN");
			
			occupyDialog.visible = false;
			currentPlayer.purchase(activeTile.getData());
			farmMap.removeChild(activeTile);
			var tileArray:Array = currentPlayer.getTile();
			var index = tileArray.indexOf(activeTile.getData());
			farmMap.getFarmTile(tileArray[index]).visible = true;
			farmMap.getFarmTile(tileArray[index + 1]).visible = true;
			farmMap.getFarmTile(tileArray[index + FarmMap.FARMTILE_X]).visible = true;
			farmMap.getFarmTile(tileArray[index + FarmMap.FARMTILE_X + 1]).visible = true;
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( farmMap.getFarmTile(tileArray[index]).getData() );
			tileToSave.push( farmMap.getFarmTile(tileArray[index + 1]).getData() );
			tileToSave.push( farmMap.getFarmTile(tileArray[index + FarmMap.FARMTILE_X]).getData() );
			tileToSave.push( farmMap.getFarmTile(tileArray[index + FarmMap.FARMTILE_X + 1]).getData() );
			
			currentPlayer.updateToServer( tileToSave, null );
		}
		
		public function onBuildPanelBuild(event:BuildEvent){
			AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
			
			buildPanel.visible = false;
			var buildId:String = event.getBuildingId();
			var b:Building = BuildingManager.getInstance().getMatchBuilding(buildId);
			currentPlayer.build(activeTile.getData(), b);
			farmMap.updateTile(activeTile);
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			
			//Add item to save data
			var itemToSave:Array = new Array();
			itemToSave.push( activeTile.getData().getBuilding().getBuildItem() );
			
			currentPlayer.updateToServer( tileToSave, itemToSave );
		}
		
		public function onMoveDestination(event:FarmMapEvent){
			trace("Move Destination");
			setPlayStateNormal();
			var destinationTile:Tile = event.getClickedTile().getData();
			if(currentPlayer.isMoveable(activeTile.getData(), destinationTile)){
				AudioManager.getInstance().playEffect("EFFECT_LAND_CLICK");
				
				currentPlayer.moveTile(activeTile.getData(), destinationTile);
				farmMap.updateTile(activeTile);
				farmMap.updateTile(event.getClickedTile());
			}
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( activeTile.getData() );
			tileToSave.push( destinationTile );
			
			currentPlayer.updateToServer( tileToSave, null );
		}
		
		public function onCouponExchangeViewCode(event:CouponEvent){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			currentPlayer.couponCodeView(event.getItemId());
		}
		
		public function onCouponExchangeExchange(event:CouponEvent){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			couponConfirmDialog.visible = true;
			var c:CouponExchangeItemBox2 = couponConfirmDialog.getCoupon();
			var item:Item = ItemManager.getInstance().getMatchItem(event.getItemId());
			var itemExchange:ItemExchangeItem = item.getExchangeItem()[0];
			couponConfirmDialog.setItemId(item.getId());
			c.setItemId(item.getId());
			c.setName(item.getName());
			c.setItemQuantity(currentPlayer.getItemQuantity(itemExchange.getItem()));
			c.setItemRequire(itemExchange.getQuantity());
			c.setPicture(ItemPictureBuilder.createCouponExchangeItemBox2Picture(item));
			currentPlayer.updateToServer( null, null );
		}
		
		public function onShopDialogClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			shopDialog.visible = false;
		}
		
		public function onShopDialogBuy(event:ShopEvent){
			AudioManager.getInstance().playEffect("EFFECT_COIN");
			currentPlayer.buy(event.getItemId(), 1);
		}
		
		public function onShopDialogSell(event:ShopEvent){
			AudioManager.getInstance().playEffect("EFFECT_COIN");
			
			currentPlayer.sell(event.getItemId(), 1);
		}
		
		public function onLevelUp(event:Event){
			levelUpDialog.visible = true;
			var smallMC:MovieClip = smallLevelFont.getMovieClip(currentPlayer.getLevel().toString(), 
							BitmapFont.H_CENTER | BitmapFont.TOP);
			statusUI.setNumberMC(smallMC);
			var bigMC:MovieClip = bigLevelFont.getMovieClip(currentPlayer.getLevel().toString(), 
							BitmapFont.H_CENTER | BitmapFont.TOP);
			levelUpDialog.setNumberMC(bigMC);
			AudioManager.getInstance().playEffect("EFFECT_LEVELUP");
		}
		
		public function onUpdateExp(event:Event){
			expProgress.setProgress(currentPlayer.getExpProgress());
		}
		
		public function onLevelUpDialogClose(event:Event){
			levelUpDialog.visible = false;
		}
		
		public function onSpecialCodeFail(evnet:Event){
			trace("Special Code Fail");
			specialCodeDialog.visible = true;
			specialCodeDialog.setMessage(true);
		}
		
		public function onSpecialCodeSuccess(event:ItemPairEvent){
			AudioManager.getInstance().playEffect("EFFECT_BONUS");
			
			getItemDialog.visible = true;
			var mc:DisplayObject = ItemPictureBuilder.createItemGetPicture(event.getItemPair().getItemId());
			getItemDialog.setData(mc, event.getItemPair());
		}
		
		public function onCodeReceive(event:CodeViewEvent){
			var item:Item = ItemManager.getInstance().getMatchItem(event.getItemId());
			var cBox:CouponExchangeItemBox3 = couponViewDialog.getCoupon();
			cBox.setName(item.getName());
			cBox.setPicture(ItemPictureBuilder.createCouponExchangeItemBox3Picture(item));
			couponViewDialog.setCoupon(event.getCode());
			couponViewDialog.setExpireDate(event.getExpireDate());
			couponViewDialog.visible = true;
			
			//Add item to save data
			var itemToSave:Array = new Array();
			//Coupon
			itemToSave.push( item );
			
			//Exchange item
			var extraItem:Item = ItemManager.getInstance().getMatchItem(item.getId());
			for each(var fetchExtraItem:ItemExchangeItem in extraItem.getExchangeItem() ){
				itemToSave.push( fetchExtraItem.getItem() );
			}
			
			currentPlayer.updateToServer( null, itemToSave );
		}
		
		public function onGetItemDialogClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			getItemDialog.visible = false;
		}
		
		public function onItemUpdate(event:Event){
			if(shopDialog.visible){
				onShopClick(null);
			}
			if(couponExchangeDialog.visible){
				onCouponButtonClick(null);
			}
		}
		
		public function onCouponConfirmClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			couponConfirmDialog.visible = false;
		}
		
		public function onCouponConfirmConfirm(event:CouponEvent){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			couponConfirmDialog.visible = false;
			currentPlayer.exchange(event.getItemId());
		}
		
		public function onCouponViewClose(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_CHOOSE_CLICK");
			
			couponViewDialog.visible = false;
		}
		
		public function onExchangeSuccess(event:CodeViewEvent){
			currentPlayer.couponCodeView(event.getItemId());
			AudioManager.getInstance().playEffect("EFFECT_BONUS");
		}
		
		public function onOptionBarOpen(event:Event){
			var expanded:OptionBarExpand = optionBar.getExpaned();
			expanded.setOption(expanded.isSoundOn(), !farmMap.isMaxZoomIn(), !farmMap.isMaxZoomOut());
		}
		
		public function onOptionBarClick(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_BUTTON_CLICK");
		}
		
		public function onSoundOn(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_ON_OFF_CLICK");
			
			var expanded:OptionBarExpand = optionBar.getExpaned();
			AudioManager.getInstance().setSound(false);
			expanded.setOption(false, expanded.isZoomInEnable(), expanded.isZoomOutEnable());
		}
		
		public function onSoundOff(event:Event){
			var expanded:OptionBarExpand = optionBar.getExpaned();
			AudioManager.getInstance().setSound(true);
			expanded.setOption(true, expanded.isZoomInEnable(), expanded.isZoomOutEnable());
		}
		
		public function onZoomIn(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_ON_OFF_CLICK");
			
			var expanded:OptionBarExpand = optionBar.getExpaned();
			farmMap.zoomIn();
			expanded.setOption(expanded.isSoundOn(), !farmMap.isMaxZoomIn(), !farmMap.isMaxZoomOut());
		}
		
		public function onZoomOut(event:Event){
			AudioManager.getInstance().playEffect("EFFECT_ON_OFF_CLICK");
			
			var expanded:OptionBarExpand = optionBar.getExpaned();
			farmMap.zoomOut();
			expanded.setOption(expanded.isSoundOn(), !farmMap.isMaxZoomIn(), !farmMap.isMaxZoomOut());
		}
		
		public function onTileUpdate(event:TileUpdateEvent){
			var tile:Tile = event.getTile();
			farmMap.updateTile(farmMap.getFarmTile(tile));
			
			trace("TileUpdate");
			
			//Add tile to save data
			var tileToSave:Array = new Array();
			tileToSave.push( tile );
			
			currentPlayer.updateToServer( tileToSave, null );
		}
		
		public function onNewspaperComplete(event:Event){
			newspaperDialog.setHTML(event.target.data);
		}
		
		public function onNewspaperPage2Complete(event:Event){
			newspaperDialog.setHTMLPage2(event.target.data);
		}
		
		public function onNewspaperError(event:IOErrorEvent){
			trace("Newspaper Error");
		}
		
		public function onNewspaperSecurityError(event:SecurityErrorEvent){
			trace("Security Error");
		}

	}
}