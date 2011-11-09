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
		
		public function GamePlay() {
			currentPlayer = SystemConstructor.getInstance().getCurrentPlayer();
			currentPlayer.addEventListener(Player.LEVELUP, onLevelUp);
			currentPlayer.addEventListener(Player.UPDATE_EXP, onUpdateExp);
			currentPlayer.addEventListener(Player.SPECIAL_CODE_FAIL, onSpecialCodeFail);
			currentPlayer.addEventListener(Player.SPECIAL_CODE_SUCCESS, onSpecialCodeSuccess);
			mouseCursor = new MouseCursor();
			mouseCursor.mouseEnabled = false;
			Mouse.hide();
			//---- init interface ----
			//init FarmMap which consist of playTile, decorated area, market place
			farmMap = new FarmMap();
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
			statusUI.setLevel(currentPlayer.getLevel().toString());
			expProgress = new ProgressBar();
			var progressMC:ExpProgress = new ExpProgress();
			expProgress.setMC(progressMC);
			expProgress.setSize(115);
			expProgress.setProgress(currentPlayer.getExpProgress());
			statusUI.setProgressMC(expProgress);
			optionBar = new OptionBar();
			optionBar.x = OPTIONBAR_X;
			optionBar.y = OPTIONBAR_Y;
			this.addChild(farmMap);
			this.addChild(couponButton);
			this.addChild(specialCodeButton);
			this.addChild(moneyUI);
			this.addChild(statusUI);
			this.addChild(optionBar);
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
			couponExchangeDialog.addEventListener(CouponExchangeDialog.VIEW_CODE, onCouponExchangeViewCode);
			couponExchangeDialog.addEventListener(CouponExchangeDialog.EXCHANGE, onCouponExchangeExchange);
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
			sellPaging.setGap(90, 200);
			sellPaging.setItemPerPage(6, 1);
			shopDialog.setSellPaging(sellPaging);
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
			
			AudioManager.getInstance().playBG("MUSIC_1");
			this.addChild(mouseCursor);
			/*//Test System
			var arrayBuilding:Array = BuildingManager.getInstance().getBuilding();
			var arrayItem:Array = ItemManager.getInstance().getItem();
			
			//trace(currentPlayer.isAllowToExtra2(currentPlayer.getTile()[37]));
			//trace(currentPlayer.isAllowToSupply(currentPlayer.getTile()[37]));
			//trace(currentPlayer.enoughResourceToBuild(arrayBuilding[0]));
			//currentPlayer.build(2, 2, arrayBuilding[0]); //tile[18]
			
			//currentPlayer.supplyItem(currentPlayer.getTile()[18]);
			//currentPlayer.extraItem(currentPlayer.getTile()[18], arrayItem[52]);
			//currentPlayer.harvest(currentPlayer.getTile()[18]);
			//currentPlayer.purchase(currentPlayer.getTile()[0]);
			currentPlayer.updateToServer();*/
			//trace(currentPlayer.getMoney());
			//Debug.getInstance().debug("This is current money : " + currentPlayer.getMoney());
			//currentPlayer.couponCodeView("5010");
			/*var testArray:Array = ItemManager.getInstance().getItemByType("special");
			for each(var showArray:Item in testArray){
				trace(showArray.getItemType(), showArray.getName());
			}*/
			/*currentPlayer.getSellableItem();
			for each(var arrayItem:ItemQuantityPair in currentPlayer.getSellableItem()){
				trace(arrayItem.getItem().getName());
			}*/
			/*currentPlayer.getBackpack();
			for each(var arrayItem:ItemQuantityPair in currentPlayer.getBackpack()){
				trace(arrayItem.getItem().getName());
			}*/
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
		}
		
		public function onTutorialClose(event:Event){
			tutorialDialog.visible = false;
			setStateNewspaper();
		}
		
		public function onNewspaperClose(event:Event){
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
		}
		
		public function onTilePurchase(event:FarmMapEvent){
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
			activeTile = event.getClickedTile();
			buildPanel.visible =true;
			var tile:Tile = event.getClickedTile().getData();
			var buildingList:Array = BuildingManager.getInstance().getBuildingForLandType(tile.getLandType());
			var itemBox:Array = createBuildItemBox(buildingList);
			buildPanel.setBuildItemBox(itemBox);
			buildPaging.setItem(itemBox);
			buildPaging.setCurrentPage(0);
		}
		
		public function createBuildItemBox(buildingArray:Array):Array{
			var boxArray:Array = new Array();
			for each(var building:Building in buildingArray){
				var box:BuildItemBox = new BuildItemBox();
				box.setBuildingId(building.getId());
				box.setTitle(building.getName());
				box.setDuration(building.getBuildPeriod());
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
			activeTile = event.getClickedTile();
			var isSupply:Boolean = currentPlayer.isAllowToSupply(activeTile.getData());
			var isExtra1:Boolean = currentPlayer.isAllowToExtra1(activeTile.getData());
			var isExtra2:Boolean = currentPlayer.isAllowToExtra2(activeTile.getData());
			addItemPanel.setButtonState(isSupply, isExtra1, isExtra2, true);
			addItemPanel.visible = true;
			currentPlayer.updateToServer();
		}
		
		public function onTileHarvest(event:FarmMapEvent){
			activeTile = event.getClickedTile();
			currentPlayer.harvest(event.getClickedTile().getData());
			farmMap.updateTile(event.getClickedTile());
			currentPlayer.updateToServer();
		}
		
		public function onShopClick(event:Event){
			trace("shop click");
			shopDialog.visible = true;
			var buyItem:Array = ItemManager.getInstance().getItemByType("normal");	//array of item
			var sellItem:Array = currentPlayer.getSellableItem();					//array of ItemQuantityPair
			var buyBoxList:Array = new Array();
			var sellBoxList:Array = new Array();
			for each(var item:Item in buyItem){
				var buyBox:ShopBuyItemBox = new ShopBuyItemBox();
				buyBoxList.push(buyBox);
			}
			for each(var backpack:ItemQuantityPair in sellItem){
				var sellBox:ShopSellItemBox = new ShopSellItemBox();
				sellBoxList.push(sellBox);
				sellBox.setItemId(backpack.getItem().getId());
				sellBox.setName(backpack.getItem().getName());
				sellBox.setQuantity(backpack.getItemQty());
				sellBox.setPrice(backpack.getItem().getSellPrice());
			}
			sellPaging.setItem(sellBoxList);
			sellPaging.setCurrentPage(0);
			shopDialog.setBuyItemBox(buyBoxList);
			shopDialog.setSellItemBox(sellBoxList);
		}
		
		public function onCouponButtonClick(event:MouseEvent){
			couponExchangeDialog.visible = true;
			var itemBoxList:Array = new Array();
			var couponItemList:Array = ItemManager.getInstance().getItemByType("coupon");
			for each(var item:Item in couponItemList){
				var box:MovieClip;
				if(currentPlayer.isItemEnough(item.getId(), 1)){
					box = new CouponExchangeItemBox2();
					CouponExchangeItemBox2(box).setItemId(item.getId());
				} else {
					box = new CouponExchangeItemBox1();
					CouponExchangeItemBox1(box).setItemId(item.getId());
				}
				itemBoxList.push(box);
			}
			couponExchangeDialog.setItemBox(itemBoxList);
		}
		
		public function onSpecialCodeButtonClick(event:MouseEvent){
			setStateSpecialCode();
		}
		
		public function onSpeicalCodeClose(event:Event){
			specialCodeDialog.visible = false;
		}
		
		public function onSpecialCodeConfirm(event:Event){
			specialCodeDialog.visible = false;
			currentPlayer.specialCodeInput(specialCodeDialog.getCode());
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
		
		public function onSupplyItem(event:Event){
			addItemPanel.visible = false;
			currentPlayer.supplyItem(activeTile.getData());
			currentPlayer.updateToServer();
		}
		
		public function onExtraItem1(event:Event){
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem1();
			currentPlayer.extraItem(activeTile.getData(), i);
			currentPlayer.updateToServer();
		}
	
		public function onExtraItem2(event:Event){
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem2();
			currentPlayer.extraItem(activeTile.getData(), i);
			currentPlayer.updateToServer();
		}
		
		public function onMoveBuilding(event:Event){
			trace("move");
			addItemPanel.visible = false;
			setPlayStateMoving();
			currentPlayer.updateToServer();
		}
		
		public function onOccupyClose(event:Event){
			occupyDialog.visible = false;
		}
		
		public function onOccupyConfirm(event:Event){
			occupyDialog.visible = false;
			currentPlayer.purchase(activeTile.getData());
			farmMap.removeChild(activeTile);
			currentPlayer.updateToServer();
		}
		
		public function onBuildPanelBuild(event:BuildEvent){
			buildPanel.visible = false;
			var buildId:String = event.getBuildingId();
			var b:Building = BuildingManager.getInstance().getMatchBuilding(buildId);
			currentPlayer.build(activeTile.getData(), b);
			farmMap.updateTile(activeTile);
			currentPlayer.updateToServer();
		}
		
		public function onMoveDestination(event:FarmMapEvent){
			trace("Move Destination");
			setPlayStateNormal();
			var destinationTile:Tile = event.getClickedTile().getData();
			if(currentPlayer.isMoveable(activeTile.getData(), destinationTile)){
				currentPlayer.moveTile(activeTile.getData(), destinationTile);
				farmMap.updateTile(activeTile);
				farmMap.updateTile(event.getClickedTile());
			}
		}
		
		public function onCouponExchangeViewCode(event:CouponEvent){
			trace("view code : " + event.getItemId());
		}
		
		public function onCouponExchangeExchange(event:CouponEvent){
			trace("exchange : " + event.getItemId());
		}
		
		public function onShopDialogClose(event:Event){
			shopDialog.visible = false;
		}
		
		public function onShopDialogBuy(event:ShopEvent){
			
		}
		
		public function onShopDialogSell(event:ShopEvent){
			trace("Sell : " + event.getItemId());
		}
		
		public function onLevelUp(event:Event){
			levelUpDialog.visible = true;
			statusUI.setLevel(currentPlayer.getLevel().toString());
		}
		
		public function onUpdateExp(event:Event){
			expProgress.setProgress(currentPlayer.getExpProgress());
		}
		
		public function onLevelUpDialogClose(event:Event){
			levelUpDialog.visible = false;
		}
		
		public function onSpecialCodeFail(evnet:Event){
			trace("Special Code Fail");
		}
		
		public function onSpecialCodeSuccess(event:Event){
			getItemDialog.visible = true;
		}
		
		public function onGetItemDialogClose(event:Event){
			getItemDialog.visible = false;
		}
	}
}