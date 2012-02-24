package cocahappymachine.ui {
	import flash.display.MovieClip;
	import Resources.EmptyFarmTile;
	import flash.events.MouseEvent;
	import cocahappymachine.util.DragManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.data.Tile;
	import Resources.Shop;
	import flash.events.Event;
	import flash.display.Stage;
	import Resources.PurchaseTile;
	import Resources.Map;
	import cocahappymachine.util.DragConstrain;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	
	public class FarmMap extends MovieClip implements DragConstrain {
		
		public static const ZOOM_STEP:Array = [0.48, 0.6, 0.8, 1, 1.2];
		public static const START_ZOOM_STEP:int = 2;
		
		public static const SHOP_CLICK:String = "SHOP_CLICK";
		
		private static const CHARACTER_START_X:int = 2300;
		private static const CHARACTER_START_Y:int = 1020;
		public static const CHARACTER_MIN_X:int = 620;
		public static const CHARACTER_MIN_Y:int = 1020;
		public static const CHARACTER_MAX_X:int = 2318;
		public static const CHARACTER_MAX_Y:int = 1460;

		private static const INIT_X:int = -1180;
		private static const INIT_Y:int = -500;
		private static const SHOP_X:int = 1405;
		private static const SHOP_Y:int = 460;
		private static const FARMTILE_START_X:int = 1354;
		private static const FARMTILE_START_Y:int = 838;
		
		public static const FARMTILE_X:int = 8;
		public static const FARMTILE_Y:int = 8;
		private static const FARMSIZE_X:int = 3000;
		private static const FARMSIZE_Y:int = 3000;
		
		private static const X_OFFSET_COLUMN:int = 150;
		private static const Y_OFFSET_COLUMN:int = 75;
		private static const X_OFFSET_ROW:int = -150;
		private static const Y_OFFSET_ROW:int = 75;
		
		private var farmTile:Array;		//array of AbstractFarmTile
		private var shop:Shop;
		private var currentPlayer:Player;
		private var currentZoomStep:int;
		private var map:MovieClip;
		private var s:Stage
		private var popItem:Array;		//array of MovieClip
		
		private var character:Character;
		
		public function FarmMap(s:Stage) {
			this.s = s;
			popItem = new Array();
			//---- draw farm bg ----//
			map = new Map();
			this.addChild(map);
			
			DragManager.getInstance().addObject(this);
			
			shop = new Shop();
			shop.addEventListener(MouseEvent.CLICK, onShopClick);
			shop.x = SHOP_X;
			shop.y = SHOP_Y;
			currentZoomStep = START_ZOOM_STEP;
			this.scaleX = ZOOM_STEP[currentZoomStep];
			this.scaleY = ZOOM_STEP[currentZoomStep];
			this.addChild(shop);
			this.x = INIT_X;
			this.y = INIT_Y;
		}
		
		public function zoomIn(){
			currentZoomStep = Math.min(ZOOM_STEP.length - 1, currentZoomStep + 1);
			this.scaleX = ZOOM_STEP[currentZoomStep];
			this.scaleY = ZOOM_STEP[currentZoomStep];
			fixPosition();
		}
		
		public function zoomOut(){
			currentZoomStep = Math.max(0, currentZoomStep - 1);
			this.scaleX = ZOOM_STEP[currentZoomStep];
			this.scaleY = ZOOM_STEP[currentZoomStep];
			fixPosition();
		}
		
		public function fixPosition(){
			x = Math.min(getMaxX(stage), x);
			x = Math.max(getMinX(stage), x);
			y = Math.min(getMaxY(stage), y);
			y = Math.max(getMinY(stage), y);
		}
		
		public function isMaxZoomIn():Boolean{
			if(currentZoomStep == ZOOM_STEP.length - 1){
				return true;
			}
			return false;
		}
		
		public function isMaxZoomOut():Boolean{
			if(currentZoomStep == 0){
				return true;
			}
			return false;
		}
		
		public function setCurrentPlayer(p:Player){
			character = new Character( p.getSex() );
			character.x = CHARACTER_START_X;
			character.y = CHARACTER_START_Y;
			currentPlayer = p;
			var tileData:Tile;
			farmTile = new Array();
			//---- Create Tile ----//
			for(var loop1:int = 0; loop1 < FARMTILE_X * FARMTILE_Y; loop1++){
				tileData = currentPlayer.getTile()[loop1];
				var tile:AbstractFarmTile = FarmTileBuilder.createFarmTile(tileData);
				tile.setData(tileData);
				tile.addEventListener(MouseEvent.CLICK, onTileClick);
				farmTile.push(tile);
				var xPosition:int = loop1 % FARMTILE_X;
				var yPosition:int = int(loop1 / FARMTILE_X);
				tile.x = FARMTILE_START_X + (xPosition * X_OFFSET_COLUMN) + (yPosition * X_OFFSET_ROW);
				tile.y = FARMTILE_START_Y + (xPosition * Y_OFFSET_COLUMN) + (yPosition * Y_OFFSET_ROW);
				this.addChild(tile);
				if(tileData.getBuildingStatus() == Tile.BUILDING_NOTOCCUPY){
					tile.visible = false;
				} else {
					this.updateTile(tile);
				}
//			}
			//---- Create PurchaseTile on top of tile ----//
//			for(var loop2:int = 0; loop2 < FARMTILE_X * FARMTILE_Y; loop2++){
				tileData = currentPlayer.getTile()[loop1];
				var tStatus = tileData.getBuildingStatus();
				if(tStatus == Tile.BUILDING_NOTOCCUPY){
					var tX:int = loop1 % FARMTILE_X;
					var tY:int = loop1 / FARMTILE_X;
					if((tX % 2 == 0) && (tY % 2 == 0)){
						var purchaseTile:PurchaseTile = new PurchaseTile();
						purchaseTile.setData(tileData);
						xPosition = loop1 % FARMTILE_X;
						yPosition = int(loop1 / FARMTILE_X);
						purchaseTile.x = FARMTILE_START_X + (xPosition * X_OFFSET_COLUMN) + (yPosition * X_OFFSET_ROW);
						purchaseTile.y = FARMTILE_START_Y + (xPosition * Y_OFFSET_COLUMN) + (yPosition * Y_OFFSET_ROW);
						purchaseTile.addEventListener(MouseEvent.CLICK, onPurchaseTileClick);
						this.addChild(purchaseTile);						
					}
				}
			}
			this.addChild(character);
		}
		
		public function onTileClick(event:MouseEvent){
			if(!DragManager.getInstance().isDragging()){
				var t:AbstractFarmTile = AbstractFarmTile(event.currentTarget);
				var tileData:Tile = t.getData();
				var farmEvent:FarmMapEvent;
				var tStatus:int = tileData.getBuildingStatus();
				if(tStatus == Tile.BUILDING_EMPTY){
					farmEvent = new FarmMapEvent(FarmMapEvent.TILE_BUILD);
				} else if((tStatus == Tile.BUILDING_COMPLETED) || (tStatus == Tile.BUILDING_ROTTED)){
					farmEvent = new FarmMapEvent(FarmMapEvent.TILE_HARVEST);
				} else if((tStatus == Tile.BUILDING_PROCESS1) || (tStatus == Tile.BUILDING_PROCESS2)){
					if(tileData.getSupply() <= 0){
						farmEvent = new FarmMapEvent(FarmMapEvent.TILE_SHOTCUTSUPPLY);
					} else {
						farmEvent = new FarmMapEvent(FarmMapEvent.TILE_ADDITEM);
					}
				} else {
					throw new Error("cocahappymachine.ui.FarmMap onTileClick() : Unexpected case occur");
				}
				farmEvent.setClickedTile(t);
				this.dispatchEvent(farmEvent);
				var moveEvent:FarmMapEvent = new FarmMapEvent(FarmMapEvent.MOVE_DESTINATION);
				moveEvent.setClickedTile(t);
				this.dispatchEvent(moveEvent);
			}
		}
		
		public function onPurchaseTileClick(event:MouseEvent){
			if(!DragManager.getInstance().isDragging()){
				var t:AbstractFarmTile = AbstractFarmTile(event.currentTarget);
				var tileData:Tile = t.getData();
				var farmEvent:FarmMapEvent = new FarmMapEvent(FarmMapEvent.TILE_PURCHASE);
				farmEvent.setClickedTile(t);
				this.dispatchEvent(farmEvent);
			}
		}
		
		public function onShopClick(event:MouseEvent){
			this.dispatchEvent(new Event(SHOP_CLICK));
		}
		
		public function updateTile(tile:AbstractFarmTile){
			if(this.contains(character)){
				this.removeChild(character);
			}
			var childIndex:int = this.getChildIndex(tile);
			this.removeChild(tile);
			var arrayIndex:int = farmTile.indexOf(tile);
			var newTile:AbstractFarmTile = FarmTileBuilder.createFarmTile(tile.getData());
			newTile.x = tile.x;
			newTile.y =  tile.y;
			newTile.setData(tile.getData());
			if((tile.getData().getBuilding() == null) || (tile.getData().getSupply() > 0)){
				newTile.setBubble(null);
			} else if((tile.getData().getSupply() <= 0) && 
					  ((tile.getData().getBuildingStatus() == Tile.BUILDING_PROCESS1)
					   || (tile.getData().getBuildingStatus() == Tile.BUILDING_PROCESS2))){
				newTile.setBubble(ItemPictureBuilder.createSupplyBubblePicture(tile.getData().getBuilding()));
			}
			newTile.setAnimate(ItemPictureBuilder.createTileAnimation(tile.getData().getExtraId()));
			newTile.addEventListener(MouseEvent.CLICK, onTileClick);
			farmTile[arrayIndex] = newTile;
			this.addChildAt(newTile, childIndex);
			this.addChild(character);
		}
		
		public function getFarmTile(t:Tile):AbstractFarmTile{
			for(var loop1:int = 0; loop1 < farmTile.length; loop1++){
				if(farmTile[loop1].getData() == t){
					return farmTile[loop1];
				}
			}
			return null;
		}
		
		public function getMinX(stage:Stage):Number{
			return stage.stageWidth - this.width;
		}
		
		public function getMinY(stage:Stage):Number{
			return stage.stageHeight - this.height;
		}
		
		public function getMaxX(stage:Stage):Number{
			return 0;
		}
		
		public function getMaxY(stage:Stage):Number{
			return 0;
		}
		
		public function setPopItem(t:AbstractFarmTile, mcArray:Array){
			var i:int = 0;
			for each(var mc:MovieClip in mcArray){
				mc.x = t.x + t.width / 2;
				mc.y = t.y;
				TweenLite.to(mc, 0.5, {y: t.y - 20, delay:i/4 } );
				TweenLite.to(mc, 1, {y: t.y + 20, delay:0.5 + i/4, overwrite:false} );
				TweenLite.to(mc, 1.5, {x: mc.x + (Math.random() * 200) - 100, overwrite:false} );
				TweenLite.to(mc, 0.2, {alpha: 0, delay:1.3, overwrite:false});
				TweenLite.delayedCall(5, onRemovePopItem, [mc]);
				this.addChild(mc);
				popItem.push(mc);
				i++;
			}
		}
		
		public function onRemovePopItem(mc:MovieClip){
			this.removeChild(mc);
			popItem.slice(popItem.indexOf(mc), 1);
		}
		
		public function getCharacter():Character{
			return this.character;
		}
	}
}