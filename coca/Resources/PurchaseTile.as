package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.ui.AbstractFarmTile;
	
	
	public class PurchaseTile extends AbstractFarmTile {
		
		private var hitMC:MovieClip;
		
		public function PurchaseTile() {
			hitMC = new PurchaseHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
		}
	}
}
