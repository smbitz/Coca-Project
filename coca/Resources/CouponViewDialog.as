package Resources {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class CouponViewDialog extends MovieClip {
		
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		private static var COUPON_EXPIRE_TIME:int = 14; // 15 days
		
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
			//Month is 0-11 then must (-1)
			var exchangeSetDate:Date = new Date( setText.slice(0, 4), Number( setText.slice(5, 7) )-1, setText.slice(8, 10), 0, 0, 0, 0);
			
			//var millisecondsPerDay:Number = 1000 * 60 * 60 * 24;
			var expireSetDate:Date = new Date( exchangeSetDate.getFullYear(), exchangeSetDate.getMonth(), exchangeSetDate.getDate()+COUPON_EXPIRE_TIME, 0,0,0,0);
			//var expireSetDate:Date = new Date();
			//exporeSetDate.setTime( exchangeSetDate.getTime()+(millisecondsPerDay*COUPON_EXPIRE_TIME) );
			
			var expireDateText:String = expireSetDate.getDate().toString();
			
			if((expireDateText.length)==1){
				expireDateText = "0"+expireDateText;
			}
			
			//Month is 0-11 then must (+1)
			var expireMonthText:String = (expireSetDate.getMonth()+1).toString();
			
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
