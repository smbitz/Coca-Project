package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	import Resources.FarmTileHitArea;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import Resources.SupplyBubble;
	import flash.display.DisplayObject;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		private var hitMC:MovieClip;
		protected var glowFilter:GlowFilter;
		protected var bubble:SupplyBubble;
		
		public function AbstractFarmTile(t:AbstractFarmTile=null) {
			if(t != null){
				tileData = t.getData()
			}
			glowFilter = new GlowFilter(0xFFFFFF, 0.8, 8, 8, 5);
			hitMC = new FarmTileHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			bubble = new SupplyBubble();
			bubble.visible = false;
			bubble.x = this.width / 2;
			bubble.y = this.height / 3;
			this.addChild(bubble);
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function setBubble(mc:DisplayObject){
			if(mc == null){
				bubble.visible = false;
			} else {
				bubble.visible = true;
				while(bubble.numChildren > 1){
					bubble.removeChildAt(1);
				}
				mc.y = - bubble.width / 2 - 10;
				bubble.addChild(mc);
			}
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