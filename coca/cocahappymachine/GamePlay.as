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
		private var activeTile:AbstractFarmTile;
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
			buildPanel.addEventListener(BuildPanel.BUILD, onBuildPanelBuild);
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
			
			AudioManager.getInstance().playBG("MUSIC_1");
			
			/*//Test System
			var arrayBuilding:Array = BuildingManager.getInstance().getBuilding();
			var arrayItem:Array = ItemManager.getInstance().getItem();
			
			trace(currentPlayer.isAllowToExtra2(currentPlayer.getTile()[37]));
			//trace(currentPlayer.isAllowToSupply(currentPlayer.getTile()[37]));
			//trace(currentPlayer.enoughResourceToBuild(arrayBuilding[0]));
			//currentPlayer.build(2, 2, arrayBuilding[0]); //tile[18]
			
			//currentPlayer.supplyItem(currentPlayer.getTile()[18]);
			//currentPlayer.extraItem(currentPlayer.getTile()[18], arrayItem[52]);
			//currentPlayer.harvest(currentPlayer.getTile()[18]);
			//currentPlayer.purchase(currentPlayer.getTile()[0]);*/
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
			activeTile = event.getClickedTile();
			occupyDialog.visible = true;
			var level:int = currentPlayer.getLevelRequiredForPurchaseTile();
			var money:int = currentPlayer.getMoneyRequiredForPurchaseTile();
			occupyDialog.setData(level, money, false, false);
		}
		
		public function onTileBuild(event:FarmMapEvent){
			activeTile = event.getClickedTile();
			buildPanel.visible =true;
			var tile:Tile = event.getClickedTile().getData();
			var buildingList:Array = BuildingManager.getInstance().getBuildingForLandType(tile.getLandType());
			var itemBox:Array = createBuildItemBox(buildingList);
			buildPanel.setBuildItemBox(itemBox);
		}
		
		public function createBuildItemBox(buildingArray:Array):Array{
			var boxArray:Array = new Array();
			for each(var building:Building in buildingArray){
				var box:BuildItemBox = new BuildItemBox();
				box.setBuildingId(building.getId());
				box.setTitle(building.getName());
				box.setBuildable(currentPlayer.isEnoughResourceToBuild(building));
				boxArray.push(box);
			}
			return boxArray;
		}
		
		public function onTileAddItem(event:FarmMapEvent){
			activeTile = event.getClickedTile();
			//change to each data
			var isSupply:Boolean = currentPlayer.isAllowToSupply(activeTile.getData());
			var isExtra1:Boolean = currentPlayer.isAllowToExtra1(activeTile.getData());
			var isExtra2:Boolean = currentPlayer.isAllowToExtra2(activeTile.getData());
			addItemPanel.setButtonState(isSupply, isExtra1, isExtra2, true);
			addItemPanel.visible = true;
		}
		
		public function onTileHarvest(event:FarmMapEvent){
			activeTile = event.getClickedTile();
			currentPlayer.harvest(event.getClickedTile().getData());
			farmMap.updateTile(event.getClickedTile());
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
		
		public function onSupplyItem(event:Event){
			addItemPanel.visible = false;
			currentPlayer.supplyItem(activeTile.getData());
		}
		
		public function onExtraItem1(event:Event){
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem1();
			currentPlayer.extraItem(activeTile.getData(), i);
		}
	
		public function onExtraItem2(event:Event){
			addItemPanel.visible = false;
			var i:Item = activeTile.getData().getBuilding().getExtraItem2();
			currentPlayer.extraItem(activeTile.getData(), i);
		}
		
		public function onMoveBuilding(event:Event){
			trace("move");
			//start move state (allow player to select move destination tile
		}
		
		public function onOccupyClose(event:Event){
			occupyDialog.visible = false;
		}
		
		public function onOccupyConfirm(event:Event){
			occupyDialog.visible = false;
			currentPlayer.purchase(activeTile.getData());
			farmMap.removeChild(activeTile);
		}
		
		public function onBuildPanelBuild(event:BuildEvent){
			buildPanel.visible = false;
			var buildId:String = event.getBuildingId();
			var b:Building = BuildingManager.getInstance().getMatchBuilding(buildId);
			currentPlayer.build(activeTile.getData(), b);
			farmMap.updateTile(activeTile);
		}
	}
}