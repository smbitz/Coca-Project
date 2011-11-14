package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import cocahappymachine.ui.ShopEvent;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	
	public class ShopBuyItemBox extends MovieClip {
		
		public static const BUY:String = "BUY";
		private static const CAN_BUY_COLOR:int = 0x431D1E;
		private static const CANT_BUY_COLOR:int = 0xFF3B00;
		
		private var itemId:String;
		
		public var nameField:TextField;
		public var timeField:TextField;
		public var priceField:TextField;
		public var buyButton:SimpleButton;
		public var timeIcon:MovieClip;
		public var pictureMC:MovieClip;		
		
		public function ShopBuyItemBox() {
			buyButton.addEventListener(MouseEvent.CLICK, onBuy);
		}
		
		public function setItemId(itemId:String){
			this.itemId = itemId;
		}
		
		public function getItemId():String{
			return itemId;
		}

		public function setName(n:String){
			nameField.text = n;
		}
		
		public function setTime(period:int){
			if(period == 0){
				timeIcon.visible = false;
				timeField.visible = false;
			} else {
				timeIcon.visible = true;
				timeField.visible = true;
				period = period / 60000;
				var minute:int = period % 60;
				var hour:int = period / 60;
				var minuteStr:String = minute.toString();
				var hourStr:String= hour.toString();
				if(minute < 10){
					minuteStr = "0" + minuteStr;
				}
				if(hour < 10){
					hourStr = "0" + hour;
				}
				timeField.text = hourStr + ":" + minuteStr + ":00";
			}
		}
		
		public function setPrice(p:int, isEnoughMoney:Boolean){
			priceField.text = p.toString();
			if(isEnoughMoney){
				priceField.textColor = CAN_BUY_COLOR;
			} else {
				priceField.textColor = CANT_BUY_COLOR;
			}
		}
		
		public function onBuy(event:MouseEvent){
			var e:ShopEvent = new ShopEvent(BUY);
			e.setItemId(itemId);
			this.dispatchEvent(e);
		}
		
		public function setPicture(mc:MovieClip){
			while(pictureMC.numChildren != 0){
				pictureMC.removeChildAt(0);
			}
			pictureMC.addChild(mc);
		}
	}
	
}
