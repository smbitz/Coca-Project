package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	import Resources.FarmTileHitArea;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		private var hitMC:MovieClip;
		protected var glowFilter:GlowFilter;
		
		public function AbstractFarmTile(t:AbstractFarmTile=null) {
			if(t != null){
				tileData = t.getData()
			}
			glowFilter = new GlowFilter(0xFFFFFF, 0.8, 5, 5, 500);
			hitMC = new FarmTileHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function getData():Tile{
			return tileData;
		}
		
		public function onMouseOut(event:MouseEvent){
			this.filters = null;
		}
		
		public function onMouseOver(event:MouseEvent){
			this.filters = [glowFilter];
		}
	}
	
}