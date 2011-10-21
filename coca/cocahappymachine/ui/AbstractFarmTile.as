package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		public function AbstractFarmTile() {
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function getData():Tile{
			return tileData;
		}
	}
	
}