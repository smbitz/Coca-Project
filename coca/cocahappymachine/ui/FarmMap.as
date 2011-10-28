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
	
	public class FarmMap extends MovieClip{
		
		public static const SHOP_CLICK:String = "SHOP_CLICK";

		private static const FARMTILE_X:int = 8;
		private static const FARMTILE_Y:int = 8;
		private static const FARMSIZE_X:int = 1000;
		private static const FARMSIZE_Y:int = 1000;
		
		private var farmTile:Array;		//array of AbstractFarmTile
		private var shop:Shop;
		private var currentPlayer:Player;
		
		public function FarmMap() {
			//---- draw farm bg ----//
			this.graphics.beginFill(0x55BB55, 1.0);
			this.graphics.drawRect(0,0, FARMSIZE_X, FARMSIZE_Y);
			this.graphics.endFill();
															   
			DragManager.getInstance().addObject(this);
			
			shop = new Shop();
			shop.addEventListener(MouseEvent.CLICK, onShopClick);
			this.addChild(shop);
		}
		
		public function setCurrentPlayer(p:Player){
			currentPlayer = p;
			var tileData:Tile;
			farmTile = new Array(FARMTILE_X * FARMTILE_Y);
			//---- Create Tile ----//
			for(var loop1:int = 0; loop1 < FARMTILE_X * FARMTILE_Y; loop1++){
				tileData = currentPlayer.getTile()[loop1];
				var tile:AbstractFarmTile = FarmTileBuilder.createFarmTile(tileData);
				tile.setData(tileData);
				tile.addEventListener(MouseEvent.CLICK, onTileClick);
				farmTile.push(tile);
				tile.x = (loop1 % FARMTILE_X) * 100;
				tile.y =  int(loop1 / FARMTILE_X) * 50;
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
						purchaseTile.x = (loop2 % FARMTILE_X) * 100;
						purchaseTile.y =  int(loop2 / FARMTILE_X) * 50
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
	}
}