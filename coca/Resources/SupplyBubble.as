package Resources {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	
	public class SupplyBubble extends MovieClip {
		
		public var itemMC:MovieClip;
		
		public function SupplyBubble() {
			this.play();
		}
		
		public function setItemMC(mc:DisplayObject){
			while(itemMC.numChildren){
				itemMC.removeChildAt(0);
			}
			itemMC.addChild(mc);
		}
	}
	
}
