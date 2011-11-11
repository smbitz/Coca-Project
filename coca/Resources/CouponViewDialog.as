package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class CouponViewDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public var closeButton:SimpleButton;
		public var couponText:TextField;
		public var coupon:CouponExchangeItemBox3;
		
		public function CouponViewDialog() {
			// constructor code
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function setCoupon(text:String){
			couponText.text = text;
		}
		
		public function getCoupon():CouponExchangeItemBox3{
			return coupon;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
