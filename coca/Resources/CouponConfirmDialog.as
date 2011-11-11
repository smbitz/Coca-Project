package Resources {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import cocahappymachine.ui.CouponEvent;
	
	
	public class CouponConfirmDialog extends MovieClip {
		
		
		public var closeButton:SimpleButton;
		public var confirmButton:SimpleButton;
		public var coupon:CouponExchangeItemBox2;
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static var DIALOG_CONFIRM:String = "DIALOG_CONFIRM";
		
		private var itemId:String;
		
		public function CouponConfirmDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			confirmButton.addEventListener(MouseEvent.CLICK, onConfirmButtonClick);
		}
		
		public function setItemId(id:String){
			itemId = id;
		}
		
		public function getCoupon():CouponExchangeItemBox2{
			return coupon;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onConfirmButtonClick(event:MouseEvent){
			var e:CouponEvent = new CouponEvent(DIALOG_CONFIRM);
			e.setItemId(itemId);
			this.dispatchEvent(e);
		}
	}
}
