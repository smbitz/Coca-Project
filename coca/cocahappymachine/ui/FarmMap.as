package cocahappymachine.ui {
	import flash.display.MovieClip;
	import Resources.EmptyFarmTile;
	import flash.events.MouseEvent;
	import cocahappymachine.util.DragManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.data.Tile;
	import Resources.Shop;
	import flash.events.Event;
	import Resources.PurchaseTile;
	import Resources.Map;
	
	public class FarmMap extends MovieClip{
		
		public static const ZOOM_STEP:Array = [0.6, 0.8, 1, 1.2];
		public static const START_ZOOM_STEP:int = 1;
		
		public static const SHOP_CLICK:String = "SHOP_CLICK";


		private static const INIT_X:int = -800;
		private static const INIT_Y:int = -450;
		private static const SHOP_X:int = 500;
		private static const SHOP_Y:int = 300;
		private static const FARMTILE_START_X:int = 1354;
		private static const FARMTILE_START_Y:int = 838;
		
		private static const FARMTILE_X:int = 8;
		private static const FARMTILE_Y:int = 8;
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
		
		public function FarmMap() {
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
		}
		
		public function zoomOut(){
			currentZoomStep = Math.max(0, currentZoomStep - 1);
			this.scaleX = ZOOM_STEP[currentZoomStep];
			this.scaleY = ZOOM_STEP[currentZoomStep];			
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
			}
			//---- Create PurchaseTile on top of tile ----//
			for(var loop2:int = 0; loop2 < FARMTILE_X * FARMTILE_Y; loop2++){
				tileData = currentPlayer.getTile()[loop2];
				var tStatus = tileData.getBuildingStatus();
				if(tStatus == Tile.BUILDING_NOTOCCUPY){
					var tX:int = loop2 % FARMTILE_X;
					var tY:int = loop2 / FARMTILE_X;
					if((tX % 2 == 0) && (tY % 2 == 0)){
						var purchaseTile:PurchaseTile = new PurchaseTile();
						purchaseTile.setData(tileData);
						xPosition = loop2 % FARMTILE_X;
						yPosition = int(loop2 / FARMTILE_X);
						purchaseTile.x = FARMTILE_START_X + (xPosition * X_OFFSET_COLUMN) + (yPosition * X_OFFSET_ROW);
						purchaseTile.y = FARMTILE_START_Y + (xPosition * Y_OFFSET_COLUMN) + (yPosition * Y_OFFSET_ROW);
						purchaseTile.addEventListener(MouseEvent.CLICK, onPurchaseTileClick);
						this.addChild(purchaseTile);						
					}
				}
			}
		}
		
		public function onTileClick(event:MouseEvent){
			if(!DragManager.getInstance().isDragging()){
				var t:AbstractFarmTile = AbstractFarmTile(event.currentTarget);
				var tileData:Tile = t.getData();
				var farmEvent:FarmMapEvent;
				var tStatus:int = tileData.getBuildingStatus();
				if(tStatus == Tile.BUILDING_EMPTY){
					farmEvent = new FarmMapEvent(FarmMapEvent.TILE_BUILD);
				} else if((tStatus == Tile.BUILDING_PROCESS1) || (tStatus == Tile.BUILDING_PROCESS2)){
					farmEvent = new FarmMapEvent(FarmMapEvent.TILE_ADDITEM);
				} else if((tStatus == Tile.BUILDING_COMPLETED) || (tStatus == Tile.BUILDING_ROTTED)){
					farmEvent = new FarmMapEvent(FarmMapEvent.TILE_HARVEST);
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
			var childIndex:int = this.getChildIndex(tile);
			this.removeChild(tile);
			var arrayIndex:int = farmTile.indexOf(tile);
			var newTile:AbstractFarmTile = FarmTileBuilder.createFarmTile(tile.getData());
			newTile.x = tile.x;
			newTile.y =  tile.y;
			newTile.setData(tile.getData());
			newTile.addEventListener(MouseEvent.CLICK, onTileClick);
			farmTile[arrayIndex] = newTile;
			this.addChildAt(newTile, childIndex);
		}
		
		public function getFarmTile(t:Tile):AbstractFarmTile{
			for(var loop1:int = 0; loop1 < farmTile.length; loop1++){
				trace(farmTile);
				trace("Loop Check"+loop1);
				if(farmTile[loop1].getData() == t){
					trace("Match");
					return farmTile[loop1];
				}
			}
			trace("No Match");
			return null;
		}
	}
}