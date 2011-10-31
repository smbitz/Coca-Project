package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		public function AbstractFarmTile(t:AbstractFarmTile=null) {
			if(t != null){
				tileData = t.getData()
			}
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function getData():Tile{
			return tileData;
		}
	}
	
}