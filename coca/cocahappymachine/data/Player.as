package cocahappymachine.data {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import cocahappymachine.util.Config;
	import flash.events.IOErrorEvent;
	import cocahappymachine.util.Debug;
	import flash.net.URLRequestMethod;
	import flash.net.FileReference;
	import flash.net.URLVariables;
	import flash.events.EventDispatcher;
	import cocahappymachine.ui.CodeViewEvent;
	import cocahappymachine.ui.CouponEvent;
	import cocahappymachine.ui.FarmMapEvent;
	import cocahappymachine.ui.TileUpdateEvent;
	import cocahappymachine.ui.ItemPairEvent;
	import cocahappymachine.ui.Character;
	
	public class Player extends EventDispatcher {

		public static const LEVELUP:String = "LEVELUP";
		public static const UPDATE_EXP:String = "UPDATE_EXP";
		public static const ITEM_UPDATE:String = "ITEM_UPDATE";
		public static const CODE_RECEIVE:String = "CODE_RECEIVE";
		public static const EXCHANGE_SUCCESS:String = "EXCHANGE_SUCCESS";
		public static const SPECIAL_CODE_SUCCESS:String = "SPECIAL_CODE_SUCCESS";
		public static const SPECIAL_CODE_FAIL:String = "SPECIAL_CODE_FAIL";
		private static const NUM_FULL_PROGRESS:int = 1;
		private static const FIRST_LEVEL:int = 1;
		private static const COUPON_RECEIVE_EACH_TIME:int = 1;
		
		//Extra item id
		private static const ITEM_ID_FERTILIZER_A:String = "7010";
		private static const ITEM_ID_FERTILIZER_B:String = "7020";
		private static const ITEM_ID_VACCINE_A:String = "7030";
		private static const ITEM_ID_VACCINE_B:String = "7040";
		private static const ITEM_ID_MICROORGANISM_A:String = "7050";
		private static const ITEM_ID_MICROORGANISM_B:String = "7060";
		
		//Item id for check extra
		private static const ITEM_ID_MORNING_GLORY:String = "160";
		private static const ITEM_ID_CHINESE_CABBAGE:String = "170";
		private static const ITEM_ID_PUMPKIN:String = "180";
		private static const ITEM_ID_BABY_CORN:String = "190";
		private static const ITEM_ID_STRAW_MUSHROOMS:String = "200";
		private static const ITEM_ID_CHICKEN:String = "210";
		private static const ITEM_ID_PIG:String = "220";
		private static const ITEM_ID_COW:String = "230";
		private static const ITEM_ID_SHEEP:String = "240";
		private static const ITEM_ID_OSTRICH:String = "250";
		private static const ITEM_ID_FISH:String = "260";
		private static const ITEM_ID_SQUID:String = "270";
		private static const ITEM_ID_SCALLOPS:String = "280";
		private static const ITEM_ID_SHRIMP:String = "290";
		private static const ITEM_ID_OYSTER:String = "300";
		
		private static const SEX_MALE = "male";
		private static const SEX_FEMALE = "female";
		
		private var facebookId:String;
		private var exp:int;
		private var money:int;
		private var isNew:String;
		private var tile:Array;		//array of Tile
		private var backpack:Array;	//array of BackpackItem
		private var name:String;
		private var sex:int;
		
		private var isLoad:Boolean;
		private var loadCallback:Function;
		
		private var bManager:BuildingManager;
		private var iManager:ItemManager;
		
		public static const TILE_MAX_X:int = 8;
		public static const TILE_MAX_Y:int = 8;
		private static const QTY_TO_BUILD:int = 1;
		private static const QTY_USE_SUPPLY:int = 1;
		private static const QTY_USE_EXTRA:int = 1;
		private static const BUY_EACH_AREA:int = 4;
		private static const QTY_START_FARM_PLAYER:int = 16;
		private static const NOT_SELL_VALUE_1:String = "coupon";
		private static const NOT_SELL_VALUE_2:String = "special";
		private static const RECEIVE_EXP_BUILD:int = 50;
		private static const RECEIVE_EXP_SUPPLY:int = 20;
		private static const RECEIVE_EXP_HARVEST:int = 100;
		private static const RECEIVE_EXP_BUY_SELL_ITEM:int = 10;
		private static const RECEIVE_EXP_EXCHANGE_COUPON:int = 500;
		
		private static const NUMBER_PERCENTS_TO_ADD_SUPPLY:int = 95;
		
		public function Player(facebookId:String,playerName:String,playerSex:String) {
			this.facebookId = facebookId;
			this.name = playerName;
			
			if( playerSex == SEX_MALE ){
				this.sex = Character.SEX_MALE;
			}else {
				this.sex = Character.SEX_FEMALE;
			}
			
			isLoad = false;
			tile = new Array();
			backpack = new Array();
			bManager = BuildingManager.getInstance();
			iManager = ItemManager.getInstance();
		}
		
		public function isLoadComplete():Boolean {
			return isLoad;
		}
		
		public function setName(name:String){
			this.name = name;
		}
		
		public function getName():String{
			return name;
		}
		
		public function getSex():int{
			return sex;
		}
		
		public function load(callback:Function){
			//load player data from server base on facebookId
			loadCallback = callback;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onXmlComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("PLAYER_URL");
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.method = URLRequestMethod.POST;
			
			//Add facebook id to url.
			var variables:URLVariables = new URLVariables();
			variables.facebook_id = facebookId;
			
			urlRequest.data = variables;
			
			urlLoader.load(urlRequest);
		}
	
		private function onXmlComplete(event:Event){
			//get list of building node
			var dataXml:XML = new XML(event.target.data);
			
			//for each building node
			for each(var playerData:XML in dataXml){
				for each(var playerDataAttributes:XML in playerData.attributes()){
					if (playerDataAttributes.name()=="facebook_id") {
						facebookId = playerDataAttributes;
					}else if (playerDataAttributes.name()=="exp") {
						exp = int(playerDataAttributes);
					}else if (playerDataAttributes.name()=="money") {
						money = int(playerDataAttributes);
					}else if (playerDataAttributes.name()=="is_new") {
						isNew = playerDataAttributes;
					}
				}
				
				//tile
				for each(var landAttributes:XML in playerData.land.tile){
					var newTile:Tile = new Tile();
					newTile.setDataFromXmlNode(landAttributes);
					tile.push(newTile);
				}
				
				//backpack
				for each(var backpackAttributes:XML in playerData.backpack.item){
					var newItem:ItemQuantityPair = new ItemQuantityPair();
					newItem.setDataFromXmlNode(backpackAttributes);
					backpack.push(newItem);
				}
			}
			isLoad = true;
			loadCallback();
		}
		
		public function getTile():Array{
			return tile;
		}
		
		public function getTileByLocate(getTileX, getTileY):Tile{
			var arrayIndex:int = getTileX + (getTileY * TILE_MAX_X);
			return tile[arrayIndex];
		}
		
		public function getBackpack():Array{
			return backpack;
		}
		
		public function getMoney():int{
			return money;
		}
		private function onIOError(event:IOErrorEvent){
			trace("player IO Error");
			load(loadCallback);
		}
		
		public function isNewGame():Boolean{
			if( isNew == "true" ){
				return true;
			}else{
				return false;
			}
		}
		
		public function update(elapse:int){
			//update all building progress with elapse
			for(var a:int = 0; a<tile.length; a++){
				var tileStatus:int = tile[a].getBuildingStatus();
				var supply:int = tile[a].getSupply();
				tile[a].update(elapse);
				if(tileStatus != tile[a].getBuildingStatus()){
					var e1:TileUpdateEvent = new TileUpdateEvent(TileUpdateEvent.TILE_UPDATE);
					e1.setTile(tile[a]);
					this.dispatchEvent(e1);
				} else if((supply > 0) && (tile[a].getSupply() <= 0)){
					var e2:TileUpdateEvent = new TileUpdateEvent(TileUpdateEvent.TILE_UPDATE);
					e2.setTile(tile[a]);
					this.dispatchEvent(e2);					
				}
			}
		}
		
		public function build(currentTile:Tile, building:Building){
			var moneyItem:int = iManager.howMoney(building.getBuildItemId());
			if(currentTile.isAllowToBuild(building)){
				if(this.isItemEnough(building.getBuildItemId(), QTY_TO_BUILD)){
					for(var c:int; c < backpack.length; c++){
						if(backpack[c].getItemId()==building.getBuildItemId()){
							backpack[c].setItemQty(backpack[c].getItemQty()-QTY_TO_BUILD);
						}
					}
					currentTile.build(building);
					this.reciveExp(RECEIVE_EXP_BUILD);
				}else if(this.money >= moneyItem*QTY_TO_BUILD){
					this.money -= (moneyItem*QTY_TO_BUILD);
					currentTile.build(building);
					this.reciveExp(RECEIVE_EXP_BUILD);
				}else {
					throw new Error("Unexpected Behavior, NO MONEY TO BUILD on build function Plaer.as");
				}
			} else {
				throw new Error("Unexpected Behavior, CAN'T BUILD SELECTED BUILDING " +
								"on build function Plaer.as");
			}			
		}
		
		public function buildByLocation(locationX:int, locationY:int, building:Building){
			var currentTile:Tile = getTileByLocate(locationX, locationY);
			this.build(currentTile, building);
		}
		
		//---- Search item in player's backpack ----//
		private function searchBackpackItem(searchItemId:String):int{
			for(var c:int; c < this.backpack.length; c++){
				if(this.backpack[c].getItemId()==searchItemId){
					return c;
				}
			}
			return -1;
		}
		
		//---- Harvest completed building on that tile ----//
		public function harvest(t:Tile):Array{
			var getYieldMoney:int = t.getBuilding().generateYieldMoney();
			var getYieldItem:Array;
			
			if(t.getBuildingStatus()==Tile.BUILDING_COMPLETED){
				getYieldItem = t.getBuilding().generateYieldItem();
				
				//Harvest Yield Item
				var getTileExtraId:String = t.getExtraId();
				var harvestPercentsExtraA:Number = (t.getBuilding().getExtra()[0].getResult())/100;
				var harvestPercentsExtraB:Number = (t.getBuilding().getExtra()[1].getResult())/100;
				
				for each(var arrayGetYieldItem:ItemQuantityPair in getYieldItem){
					var yieldItemId:String = arrayGetYieldItem.getItem().getId();
					var itemPositionBackpack:int = searchBackpackItem(yieldItemId);
					var yieldItemQty:int = arrayGetYieldItem.getItemQty();
					
					var extraQuantity:int = 0;
					
					//Match with all item id can have extra item
					if(yieldItemId==ITEM_ID_MORNING_GLORY||yieldItemId==ITEM_ID_CHINESE_CABBAGE||yieldItemId==ITEM_ID_PUMPKIN||yieldItemId==ITEM_ID_BABY_CORN||yieldItemId==ITEM_ID_STRAW_MUSHROOMS||yieldItemId==ITEM_ID_CHICKEN||yieldItemId==ITEM_ID_PIG||yieldItemId==ITEM_ID_COW||yieldItemId==ITEM_ID_SHEEP||yieldItemId==ITEM_ID_OSTRICH||yieldItemId==ITEM_ID_FISH||yieldItemId==ITEM_ID_SQUID||yieldItemId==ITEM_ID_SCALLOPS||yieldItemId==ITEM_ID_SHRIMP||yieldItemId==ITEM_ID_OYSTER){
						if(getTileExtraId==ITEM_ID_FERTILIZER_A||getTileExtraId==ITEM_ID_MICROORGANISM_A||getTileExtraId==ITEM_ID_VACCINE_A){
							extraQuantity = yieldItemQty*harvestPercentsExtraA;
						}else if(getTileExtraId==ITEM_ID_FERTILIZER_B||getTileExtraId==ITEM_ID_MICROORGANISM_B||getTileExtraId==ITEM_ID_VACCINE_B){
							extraQuantity = yieldItemQty*harvestPercentsExtraB;
						}
						
						yieldItemQty += extraQuantity;
					}
					
					if(itemPositionBackpack>=0){
						var currentBackpackQty:int = this.backpack[itemPositionBackpack].getItemQty();
						
						this.backpack[itemPositionBackpack].setItemQty(currentBackpackQty+yieldItemQty);
					}else{
						var b:ItemQuantityPair = new ItemQuantityPair();
						b.setItemQty(yieldItemQty);
						b.setItem(arrayGetYieldItem.getItem());
						b.setItemId(arrayGetYieldItem.getItem().getId())
						this.backpack.push(b);
					}
				}
				
				//Harvest Money
				this.money += getYieldMoney;
				
				//Clear Tile
				t.clearTile();
				this.reciveExp(RECEIVE_EXP_HARVEST);
				return getYieldItem;
			}else if(t.getBuildingStatus()==Tile.BUILDING_ROTTED){
				//Harvest Money
				this.money += getYieldMoney;
				
				//Clear Tile
				t.clearTile();
				this.reciveExp(RECEIVE_EXP_HARVEST);
				return getYieldItem;
			}else{
				throw new Error("Unexpected from harvest in Player.as");
			}
		}
		
		//---- Purchase that tile ----//
		public function purchase(t:Tile){
			var moneyToPurchase:int = getMoneyRequiredForPurchaseTile();
			var levelToPurchase:int = getLevelRequiredForPurchaseTile();
			
			if(this.money>=moneyToPurchase&&this.getLevel()>=levelToPurchase){
				//Calculate money
				this.money -= moneyToPurchase;
				
				//Change tile Status
				for(var i:int = 0; i < tile.length; i++){
					if(tile[i] == t){
						tile[i].setIsOccupy(true);
						tile[i + 1].setIsOccupy(true);
						tile[i + TILE_MAX_X].setIsOccupy(true);
						tile[i + TILE_MAX_X + 1].setIsOccupy(true);
					}
				}
			}else{
				throw new Error("Unexpected from purchase in Player.as");
			}
		}
		
		private function getCurrentPlayerFarm():int{
			var totalPlayerFarm:int = 0;
			for each(var arrayTile:Tile in tile){
				if(arrayTile.getIsOccupy()==true){
					totalPlayerFarm++;
				}
			}
			totalPlayerFarm -= QTY_START_FARM_PLAYER;
			totalPlayerFarm = (totalPlayerFarm/BUY_EACH_AREA)+1;
			return totalPlayerFarm;
		}
		
		//---- Calculate and return money required for purchase tile ----//
		public function getMoneyRequiredForPurchaseTile():int{
			var currentPlayerFarm:int = getCurrentPlayerFarm();
			var requireMoney:int = 5000 + (700 * (Math.pow(currentPlayerFarm, 3)) );
			return requireMoney;
		}
		
		//---- Calculate and return level required for purchase tile ----//
		public function getLevelRequiredForPurchaseTile():int{
			var currentPlayerFarm:int = getCurrentPlayerFarm();
			var requireLevel:int = 7 * currentPlayerFarm;
			return requireLevel;
		}
		
		//---- Calculate exp for level up ----//
		public function getCalculateExp(getValue:int):int{
			return 200+(300*(Math.pow(getValue, 2)));
		}
		
		public function isItemEnough(itemId:String, quantity:int):Boolean{
			//check from backpack for enough item in that itemId
			for(var b:int; b < backpack.length; b++){
				if(backpack[b].getItemId()==itemId&&backpack[b].getItemQty()>=quantity){
					return true
				}
			}
			return false;
		}
		
		public function exchange(itemId:String){
			//send request to server asking for exchange item to coupon
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onExchangeReply);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("GENERATE_COUPON_URL");
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.method = URLRequestMethod.POST;
			
			//Add facebook_id and item_id to url.
			var variables:URLVariables = new URLVariables();
			variables.facebook_id = facebookId;
			variables.item_id = itemId;
			
			urlRequest.data = variables;
			
			urlLoader.load(urlRequest);
		}
		
		//---- Callback function for exchange() ----//
		public function onExchangeReply(event:Event){
			var returnString:String = event.target.data.toString();
			var arrayReturn:Array = returnString.split(",");
			var couponId:String = arrayReturn[0];
			var itemId:String = arrayReturn[1];
			
			if(returnString=="fail"){
				//respond to player that exchange was rejected				
			}else{
				this.reciveExp(RECEIVE_EXP_EXCHANGE_COUPON);
				
				//reduce amount of item using for exchange
				var extraItem:Item = iManager.getMatchItem(itemId);
				for(var i:int; i < extraItem.getExchangeItem().length; i++){
					var backpackNumber:int = this.findItemBackpackById(extraItem.getExchangeItem()[i].getId());
					var quantityToExchange:int = iManager.getMatchItem(itemId).getExchangeItem()[i].getQuantity();
					
					this.backpack[backpackNumber].setItemQty(this.backpack[backpackNumber].getItemQty()-quantityToExchange);
				}

				//add coupon item to player backpack
				this.addItemToBackpack(itemId, COUPON_RECEIVE_EACH_TIME);
				
				var e:CodeViewEvent = new CodeViewEvent(EXCHANGE_SUCCESS);
				e.setItemId(itemId);
				e.setCode(couponId);
				this.dispatchEvent(e);
				this.dispatchEvent(new Event(ITEM_UPDATE));	
			}
		}
		
		public function couponCodeView(itemId:String){
			//send request to server asking for the code of coupon
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onCouponCodeViewReply);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("VIEW_COUPON_URL");
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.method = URLRequestMethod.POST;
			
			//Add facebook_id and item_id to url.
			var variables:URLVariables = new URLVariables();
			variables.facebook_id = facebookId;
			variables.item_id = itemId;
			
			urlRequest.data = variables;
			
			urlLoader.load(urlRequest);
		}
		
		//---- Callback function for couponCodeView() ----//
		public function onCouponCodeViewReply(event:Event){
			var returnString:String = event.target.data.toString();
			var arrayReturn:Array = returnString.split(",");
			var couponId:String = arrayReturn[0];
			var itemId:String = arrayReturn[1];
			
			if(returnString=="fail"){
				trace("Code View Fail");
			}else{
				var e:CodeViewEvent = new CodeViewEvent(CODE_RECEIVE);
				e.setCode(couponId);
				e.setItemId(itemId);
				this.dispatchEvent(e);
			}
		}
		
		public function specialCodeInput(code:String){
			//send request to server asking for the verify code
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onSpecialCodeInputReply);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var url:String = Config.getInstance().getData("USE_SPECIAL_CODE_URL");
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.method = URLRequestMethod.POST;
			
			//Add facebook_id and item_id to url.
			var variables:URLVariables = new URLVariables();
			variables.special_code = code;
			variables.facebook_id = facebookId;
			
			urlRequest.data = variables;
			
			urlLoader.load(urlRequest);
		}
		
		//---- Callback function for specialCodeInput() ----//
		public function onSpecialCodeInputReply(event:Event){
			var resultInput:String = event.target.data.toString();
			var arrayReturn:Array = resultInput.split(",");
			var itemId:String = arrayReturn[0];
			var itemQty:int = arrayReturn[1];
			
			if(resultInput=="fail"){
				this.dispatchEvent(new Event(SPECIAL_CODE_FAIL));
			}else{
				var e:ItemPairEvent = new ItemPairEvent(SPECIAL_CODE_SUCCESS);
				var pair:ItemQuantityPair = new ItemQuantityPair();
				pair.setItemId(itemId);
				pair.setItemQty(itemQty);
				pair.setItem(iManager.getMatchItem(itemId));
				e.setItemPair(pair);
				this.dispatchEvent(e);
				//add item
				this.addItemToBackpack(itemId, itemQty);
				
				this.dispatchEvent(new Event(ITEM_UPDATE));
			}
		}
		
		//---- Supply item to targetTile
		public function supplyItem(targetTile:Tile):Boolean{
			var supplyItemId:String = targetTile.getBuilding().getSupplyId();
			var moneySupply:int = iManager.howMoney(supplyItemId);
			var currentTileSupplyPercents:int = targetTile.getSupplyPercentage()*100;
			
			if(currentTileSupplyPercents<NUMBER_PERCENTS_TO_ADD_SUPPLY){
				if(isItemEnough(supplyItemId, QTY_USE_SUPPLY)){
					var searchSupply:int = this.searchBackpackItem(supplyItemId);
					var currentQty:int = this.backpack[searchSupply].getItemQty();
					
					if(searchSupply>=0){
						this.backpack[searchSupply].setItemQty(currentQty-1);
						targetTile.setSupply(targetTile.getBuilding().getSupplyPeriod());
						this.reciveExp(RECEIVE_EXP_SUPPLY);
						return true;
					}
				}else if(this.money > moneySupply){
					this.money -= moneySupply;
					targetTile.setSupply(targetTile.getBuilding().getSupplyPeriod());
					this.reciveExp(RECEIVE_EXP_SUPPLY);
					return true;
				}
			}
			return false;
		}
		
		//---- add extraItem to targetTile
		public function extraItem(targetTile:Tile, extraItem:Item):Boolean{
			var extraItemId1:String = targetTile.getBuilding().getExtraItem1().getId();
			var extraItemId2:String = targetTile.getBuilding().getExtraItem2().getId();

			if(extraItem.getId()==extraItemId1||extraItem.getId()==extraItemId2){
				if(isItemEnough(extraItem.getId(), QTY_USE_EXTRA)){
					var searchExtra:int = this.searchBackpackItem(extraItem.getId());
					var currentExtraQty:int = this.backpack[searchExtra].getItemQty();
					
					if(searchExtra>=0){
						this.backpack[searchExtra].setItemQty(currentExtraQty-1);
						targetTile.setExtraId(extraItem.getId());
						return true;
					}
				}
			}
			return false;
		}
		
		//---- Check is player have enough money / item to build this building
		public function isEnoughResourceToBuild(building:Building):Boolean{
			var moneyItem:int = iManager.howMoney(building.getBuildItemId());

			if(this.isItemEnough(building.getBuildItemId(), QTY_TO_BUILD)){
				//IF Check Item
				return true;
			}else if(this.money>(moneyItem*QTY_TO_BUILD)){
				//ELSE IF Check Money
				return true;
			}
			return false;
		}
		
		//---- Check for player have item / money using for supply ----//
		public function isAllowToSupply(activeTile:Tile):Boolean{
			var buildSupplyId:String = activeTile.getBuilding().getSupplyId();
			var moneyToBuySupply:int = iManager.howMoney(buildSupplyId);
			
			if(this.isItemEnough(buildSupplyId, QTY_USE_SUPPLY)){
				return true;
			}else if(this.money>(moneyToBuySupply*QTY_USE_SUPPLY)){
				return true;
			}
			return false;
		}
		
		//---- Check for player extra condition (1) ----//
		public function isAllowToExtra1(activeTile:Tile):Boolean{
			var requireExtraId:String = activeTile.getBuilding().getExtraItem1().getId();

			if(this.isItemEnough(requireExtraId, QTY_USE_EXTRA)&&activeTile.getExtraId()=="NULL"){
				return true;
			}
			return false;
		}
		
		//---- Check for player extra condition (2) ----//
		public function isAllowToExtra2(activeTile:Tile):Boolean{
			var requireExtraId:String = activeTile.getBuilding().getExtraItem2().getId();

			if(this.isItemEnough(requireExtraId, QTY_USE_EXTRA)&&activeTile.getExtraId()=="NULL"){
				return true;
			}
			return false;
		}
		
		//---- Check for possible move condtion (1) ----//
		public function isMoveable(moveTile:Tile, destinationTile:Tile):Boolean{
			var moveTileLandType:String = moveTile.getLandType();
			var destinationTileLandType:String = destinationTile.getLandType();
			
			if(moveTileLandType==destinationTileLandType&&destinationTile.getBuilding()==null){
				return true;
			}
			return false;
		}
		
		//---- proceed move tile ----//
		public function moveTile(moveTile:Tile, destinationTile:Tile){
			destinationTile.setBuildingId(moveTile.getBuildingId());
			destinationTile.setProgress(moveTile.getProgress());
			destinationTile.setSupply(moveTile.getSupply());
			destinationTile.setExtraId(moveTile.getExtraId());
			destinationTile.setRottenPeriod(moveTile.getRottenPeriod());
			destinationTile.setBuilding(moveTile.getBuilding());
			
			moveTile.clearTile();
		}
		
		//---- Update Player data to Server ----//
		public function updateToServer(){
			var checkValue:int;
			
			//getTileData and change millisec to sec.
			var xmlLand:XML = <land/>;
			for each(var tileData:Tile in this.tile){
				checkValue+=(int(tileData.getProgress()/1000)+int(tileData.getSupply()/1000)+int(tileData.getRottenPeriod()/1000));
				xmlLand.appendChild(<tile land_type={tileData.getLandType()} is_occupy={tileData.getIsOccupy()} building_id={tileData.getBuildingId()} progress={(tileData.getProgress()/1000)} supply_left={(tileData.getSupply()/1000)} extra_id={tileData.getExtraId()} rotten_period={(tileData.getRottenPeriod()/1000)}/>);
			}
			
			//getBackpackItem
			var xmlBackpack:XML = <backpack/>;
			for each(var backpackItem:ItemQuantityPair in this.backpack){
				checkValue-=int(backpackItem.getItemQty());
				xmlBackpack.appendChild(<item id={backpackItem.getItemId()} quantity={backpackItem.getItemQty()}/>);
			}
			
			//Create player xml.
			var xml:XML = <player facebook_id={this.facebookId} exp={this.exp} money={this.money} is_new={this.isNew} c1={checkValue}/>;
			
			xml.appendChild(xmlLand);
			xml.appendChild(xmlBackpack);
			
			var urlRequest:URLRequest = new URLRequest(Config.getInstance().getData("PLAYER_UPDATE_URL"));
			urlRequest.data = xml;
			urlRequest.contentType = "text/xml";
			urlRequest.method = URLRequestMethod.POST;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onUpdateToServerComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onUpdateToServerFail);
			loader.load(urlRequest);
		}
		
		public function onUpdateToServerComplete(event:Event){
			trace("Player Update To Server Complete");
		}
		
		public function onUpdateToServerFail(event:IOErrorEvent){
			trace("Player Update To Server IO Error");
		}
		
		//---- Calculate level and exp when receive exp ---//
		private function reciveExp(expPoint:int){
			//Check for next level
			//if level up add level,exp and call levelup,exp event
			if(this.isLevelUp(expPoint)){
				this.exp += expPoint;
				this.dispatchEvent(new Event(UPDATE_EXP));
				this.dispatchEvent(new Event(LEVELUP));
			}else{
			//else add exp call exp event
				this.exp += expPoint;
				this.dispatchEvent(new Event(UPDATE_EXP));
			}
		}
		
		//---- Check exp for next level ----//
		private function isLevelUp(checkValue:int):Boolean{
			var currentLevel:int = this.getLevel();
			var checkExp:int = this.exp+checkValue;
			var checkLevel:int;
			var expForNextLevel:int;
			
			while(checkExp>=expForNextLevel){
				checkLevel++;
				expForNextLevel = getCalculateExp( checkLevel );
			}
			
			if(currentLevel<checkLevel){
				return true;
			}else{
				return false;
			}
		}
		
		//---- calculate and return player level ----//
		public function getLevel():int{
			var currentPlayerLevel:int;
			var expForNextLevel:int;
			
			while(this.exp>=expForNextLevel){
				currentPlayerLevel++;
				expForNextLevel = getCalculateExp(currentPlayerLevel);
			}
			
			return currentPlayerLevel;
		}
		
		//---- find sellable item which owned by player ----//
		public function getSellableItem():Array{
			var arraySellAbleItem:Array = new Array();
			
			for each(var arrayItem:ItemQuantityPair in this.backpack){
				var backpackItemType:String = arrayItem.getItem().getItemType();
				
				if(backpackItemType!=NOT_SELL_VALUE_1&&backpackItemType!=NOT_SELL_VALUE_2){
					arraySellAbleItem.push(arrayItem);
				}
			}
			
			return arraySellAbleItem;
		}
		
		//---- find percentage of exp since the start of current level until level up ----//
		public function getExpProgress():Number{
			var currentProgress:Number;
			var expAtStartLevel:int;
			
			//If first lv.
			if(this.getLevel()==FIRST_LEVEL){
				expAtStartLevel = 0;
			}else{
				expAtStartLevel = getCalculateExp(this.getLevel()-1);
			}
			
			var expForNextLevel:int = getCalculateExp(this.getLevel());
			var diffExp:int = (expForNextLevel-expAtStartLevel);
			var currentExp:int = this.exp-expAtStartLevel;
			
			currentProgress = (NUM_FULL_PROGRESS/diffExp)*currentExp;
			
			return currentProgress;
		}
		
		//---- find quantity of given item ----//
		public function getItemQuantity(item:Item):int {
			var itemQuantity:int;
			var findItemBackpack:int = findItemBackpackById(item.getId());
			
			if(findItemBackpack>=0){
				itemQuantity = backpack[findItemBackpack].getItemQty();
			}
			
			return itemQuantity;
		}
		
		//---- Find item in backpack ----//
		private function findItemBackpackById(findItemId:String):int{
			for(var c:int; c < backpack.length; c++){
				if(backpack[c].getItemId()==findItemId){
					return c;
				}
			}
			
			return -1;
		}
		
		//--- buy item ----//
		public function buy(itemId:String, quantity:int){
			var currentItem:Item = iManager.getMatchItem(itemId);
			
			if(this.money>=(currentItem.getPrice()*quantity)){
				var itemPosition:int = findItemBackpackById(itemId);
				
				if(itemPosition>=0){
				   this.backpack[itemPosition].setItemQty(this.backpack[itemPosition].getItemQty()+quantity);
				}else{
				   var b:ItemQuantityPair = new ItemQuantityPair();
				   b.setItemQty(quantity);
				   b.setItem(currentItem);
				   b.setItemId(itemId)
				   this.backpack.push(b);
				}
				this.money -= (currentItem.getPrice()*quantity);
				this.reciveExp(RECEIVE_EXP_BUY_SELL_ITEM);
			}
			
			this.dispatchEvent(new Event(ITEM_UPDATE));
		}
		
		//---- sell item----//
		public function sell(itemId:String, quantity:int){
			var itemPosition:int = findItemBackpackById(itemId);
			
			if(itemPosition>=0){
				var currentItemQty:int = this.backpack[itemPosition].getItemQty();
				
				if(currentItemQty>=quantity){
					this.backpack[itemPosition].setItemQty(this.backpack[itemPosition].getItemQty()-quantity);
					this.money += (this.backpack[itemPosition].getItem().getSellPrice())*quantity;
					this.reciveExp(RECEIVE_EXP_BUY_SELL_ITEM);
				}
			}
			
			this.dispatchEvent(new Event(ITEM_UPDATE));			
		}
		
		private function addItemToBackpack(itemId:String, quantity:int){
			var findItemInBackpack:int = this.findItemBackpackById(itemId);

			if(findItemInBackpack>=0){
				this.backpack[findItemInBackpack].setItemQty(this.backpack[findItemInBackpack].getItemQty()+quantity);
			}else {
				var b:ItemQuantityPair = new ItemQuantityPair();
				b.setItemQty(quantity);
				b.setItem(iManager.getMatchItem(itemId));
				b.setItemId(iManager.getMatchItem(itemId).getId())
				this.backpack.push(b);
			}
		}
	}
}