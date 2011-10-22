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
				tile.visible = false;
				return tile;
			}
		}
	}
	
}
