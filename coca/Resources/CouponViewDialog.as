package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class CouponViewDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		private static var COUPON_EXPIRE_TIME:int = 15;
		
		public var closeButton:SimpleButton;
		public var couponText:TextField;
		public var coupon:CouponExchangeItemBox3;
		public var expireDate:TextField;
		
		public function CouponViewDialog() {
			// constructor code
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function setCoupon(text:String){
			couponText.text = text;
		}
		
		public function setExpireDate(setText:String){
			//Caluculate expire date
			var exchangeSetDate:Date = new Date( setText.slice(0, 4), setText.slice(5, 7), setText.slice(8, 10), 0, 0, 0, 0);
			var expireSetDate:Date = new Date( exchangeSetDate.getFullYear(), exchangeSetDate.getMonth(), exchangeSetDate.getDate()+COUPON_EXPIRE_TIME, 0,0,0,0);
			
			var expireDateText:String = expireSetDate.getDate().toString();
			
			if((expireDateText.length)==1){
				expireDateText = "0"+expireDateText;
			}
			
			var expireMonthText:String = expireSetDate.getMonth().toString();
			
			if((expireMonthText.length)==1){
				expireMonthText = "0"+expireMonthText;
			}
			
			var expireYearText:String = expireSetDate.getFullYear().toString().slice( 2, 4 );
			
			expireDate.text = "หมดอายุวันที่ "+expireDateText+"-"+expireMonthText+"-"+expireYearText;
		}
		
		public function getCoupon():CouponExchangeItemBox3{
			return coupon;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
	}
	
}
