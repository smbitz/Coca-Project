package cocahappymachine.ui {
	import cocahappymachine.data.Tile;
	import Resources.EmptyFarmTile;
	
	public class FarmTileBuilder {

		public function FarmTileBuilder() {
			// constructor code
		}

		public static function createFarmTile(tileData:Tile):AbstractFarmTile{
			if(tileData.getBuildingStatus() == Tile.BUILDING_EMPTY){
				return new EmptyFarmTile();
			} else {
				var tile:AbstractFarmTile = new EmptyFarmTile();	
				tile.graphics.beginFill(0x00FF00, 0.7);
				tile.graphics.drawRect(0,0, 20,20);
				tile.graphics.endFill();
				return tile;
			}
		}
	}
	
}
