package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	
	public class CouponExchangeTabContent extends MovieClip {
		
		public var leftButton:SimpleButton;
		public var rightButton:SimpleButton;
		public var couponExchangePaging:MovieClip;
		
		public function CouponExchangeTabContent() {
			// constructor code
		}
		
		public function setPaging(p:MovieClip){
			while(couponExchangePaging.numChildren != 0){
				couponExchangePaging.removeChildAt(0);
			}
			couponExchangePaging.addChild(p);
		}
	}
	
}
