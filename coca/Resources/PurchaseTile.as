package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.ui.AbstractFarmTile;
	import flash.events.MouseEvent;
	
	public class PurchaseTile extends AbstractFarmTile {
		
		private var hitMC:MovieClip;
		public var saleMC:MovieClip;
		
		public function PurchaseTile() {
			hitMC = new PurchaseHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
		}
		
		public override function onMouseOver(event:MouseEvent){
			saleMC.filters = [glowFilter];
		}

		public override function onMouseOut(event:MouseEvent){
			saleMC.filters = null;
		}

	}
}
