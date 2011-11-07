package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	import Resources.FarmTileHitArea;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		private var hitMC:MovieClip;
		
		public function AbstractFarmTile(t:AbstractFarmTile=null) {
			if(t != null){
				tileData = t.getData()
			}
			hitMC = new FarmTileHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function getData():Tile{
			return tileData;
		}
	}
	
}