package Resources {
	
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import cocahappymachine.ui.AbstractCouponExchangeItemBox;
	
	
	public class CouponExchangeItemBox2 extends AbstractCouponExchangeItemBox {

		public var requireField:TextField;
		public var itemQuantityField:TextField;
		public var nameField:TextField;
		public var pictureMC:MovieClip;
		private var quantity:int;
		
		public function CouponExchangeItemBox2() {
			// constructor code
		}

		public override function setName(n:String){
			nameField.text = n;
			setItemRequire(quantity);
		}
		
		public override function setItemQuantity(i:int){
			itemQuantityField.text = "x " + i.toString();
		}
		
		private function update(){
			setItemQuantity(quantity);
		}
		
		public override function setItemRequire(i:int){
			quantity = i;
			requireField.text = nameField.text + " x " + i.toString();
		}
		
		public override function setPicture(mc:MovieClip){
			while(pictureMC.numChildren != 0){
				pictureMC.removeChildAt(0);
			}
			pictureMC.addChild(mc);
		}
	}
	
}
