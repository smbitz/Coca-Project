package cocahappymachine.ui {
	import flash.display.MovieClip;
	import Resources.EmptyFarmTile;
	import flash.events.MouseEvent;
	import cocahappymachine.util.DragManager;
	import cocahappymachine.data.Player;
	import cocahappymachine.data.Tile;
	
	public class FarmMap extends MovieClip{

		private static const FARMTILE_X:int = 8;
		private static const FARMTILE_Y:int = 8;
		private static const FARMSIZE_X:int = 1000;
		private static const FARMSIZE_Y:int = 1000;
		
		private var farmTile:Array;		//array of AbstractFarmTile
		
		public function FarmMap() {
			//---- get player from (1) passed (2) SystemConstructor
			var currentPlayer:Player;
			//---- draw farm bg ----//
			this.graphics.beginFill(0x55BB55, 1.0);
			this.graphics.drawRect(0,0, FARMSIZE_X, FARMSIZE_Y);
			this.graphics.endFill();
															   
			farmTile = new Array(FARMTILE_X * FARMTILE_Y);
			for(var i:int = 0; i < FARMTILE_X * FARMTILE_Y; i++){
				var tileDate:Tile = currentPlayer.getTile()[i];
				//if tileData.getStatus() == STATUS_EMPTY
					//create empty tile
				//else
					//create tile from buldingId and status
					
				var tile:AbstractFarmTile = new EmptyFarmTile();
				tile.addEventListener(MouseEvent.CLICK, onTileClick);
				farmTile.push(tile);
				tile.x = (i % FARMTILE_X) * 100;
				tile.y =  int(i / FARMTILE_X) * 50
				this.addChild(tile);
			}
			DragManager.getInstance().addObject(this);
		}
		
		public function onTileClick(event:MouseEvent){
			var t:AbstractFarmTile = AbstractFarmTile(event.currentTarget);
			var tileData:Tile = t.getData();
			var farmEvent:FarmMapEvent = new FarmMapEvent(FarmMapEvent.TILE_CLICK);
			farmEvent.setClickedTile(tileData);
			this.dispatchEvent(farmEvent);
		}
	}
}