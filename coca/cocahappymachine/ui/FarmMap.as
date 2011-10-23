package cocahappymachine.ui {
	import flash.display.MovieClip;
	import Resources.EmptyFarmTile;
	import flash.events.MouseEvent;
	import cocahappymachine.util.DragManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.data.Tile;
	import Resources.Shop;
	import flash.events.Event;
	
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
			farmTile = new Array(FARMTILE_X * FARMTILE_Y);
			for(var i:int = 0; i < FARMTILE_X * FARMTILE_Y; i++){
				var tileData:Tile = currentPlayer.getTile()[i];
				var tile:AbstractFarmTile = FarmTileBuilder.createFarmTile(tileData);
				tile.setData(tileData);
				tile.addEventListener(MouseEvent.CLICK, onTileClick);
				farmTile.push(tile);
				tile.x = (i % FARMTILE_X) * 100;
				tile.y =  int(i / FARMTILE_X) * 50
				this.addChild(tile);
			}
			//for empty tile
				//create purchase tile on top of 2 x 2 tile
		}
		
		public function onTileClick(event:MouseEvent){
			var t:AbstractFarmTile = AbstractFarmTile(event.currentTarget);
			var tileData:Tile = t.getData();
			var farmEvent:FarmMapEvent;
			var tStatus:int = tileData.getBuildingStatus();
			//if tileData status is not occupy
				farmEvent = new FarmMapEvent(FarmMapEvent.TILE_PURCHASE);
			if(tStatus == Tile.BUILDING_EMPTY){
				farmEvent = new FarmMapEvent(FarmMapEvent.TILE_BUILD);
			} else if((tStatus == Tile.BUILDING_PROCESS1) || (tStatus == Tile.BUILDING_PROCESS2)){
				farmEvent = new FarmMapEvent(FarmMapEvent.TILE_ADDITEM);
			} else if((tStatus == Tile.BUILDING_COMPLETED) || (tStatus == Tile.BUILDING_ROTTED)){
				farmEvent = new FarmMapEvent(FarmMapEvent.TILE_HARVEST);
			} else {
				throw new Error("cocahappymachine.ui.FarmMap onTileClick() : Unexpected case occur");
			}
			farmEvent.setClickedTile(tileData);
			this.dispatchEvent(farmEvent);
		}
		
		public function onShopClick(event:MouseEvent){
			this.dispatchEvent(new Event(SHOP_CLICK));
		}
	}
}