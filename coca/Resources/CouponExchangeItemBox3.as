package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.ui.AbstractCouponExchangeItemBox;
	import flash.text.TextField;
	
	public class CouponExchangeItemBox3 extends AbstractCouponExchangeItemBox {
		
		public var requireField:TextField;
		public var nameField:TextField;
		public var pictureMC:MovieClip;
		
		public function CouponExchangeItemBox3() {
			// constructor code
		}
		
		public override function setName(n:String){
			nameField.text = n;
			requireField.text = n + "ได้ที่โคคาสุกี้";
		}
		
		public override function setItemRequire(i:int){
			requireField.text = i.toString();
		}
		
		public override function setPicture(mc:MovieClip){
			while(pictureMC.numChildren != 0){
				pictureMC.removeChildAt(0);
			}
			pictureMC.addChild(mc);
		}
	}
	
}
