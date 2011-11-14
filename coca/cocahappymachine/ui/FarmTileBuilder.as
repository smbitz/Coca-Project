package cocahappymachine.ui {
	import cocahappymachine.data.Tile;
	import Resources.EmptyFarmTile;
	import Resources.MorningGlory1Tile;
	import Resources.MorningGlory2Tile;
	import Resources.MorningGlory3Tile;
	import Resources.MorningGlory4Tile;
	
	public class FarmTileBuilder {
		
		private static const MORNING_GlORY_BUILD_ID = "10";
		
		public function FarmTileBuilder() {
			// constructor code
		}

		public static function createFarmTile(tileData:Tile):AbstractFarmTile{
			if(tileData.getBuildingStatus() == Tile.BUILDING_NOTOCCUPY){
				return new EmptyFarmTile();
			} else if(tileData.getBuildingStatus() == Tile.BUILDING_EMPTY){
				return new EmptyFarmTile();
			} else if(tileData.getBuildingId() == MORNING_GlORY_BUILD_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new MorningGlory1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new MorningGlory2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new MorningGlory3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new MorningGlory4Tile;
				}
			} else {
				var tile:AbstractFarmTile = new EmptyFarmTile();	
				tile.graphics.beginFill(0x00FF00, 0.7);
				tile.graphics.drawRect(0,0, 20,20);
				tile.graphics.endFill();
				return tile;
			}
			return null;
		}
	}
	
}
