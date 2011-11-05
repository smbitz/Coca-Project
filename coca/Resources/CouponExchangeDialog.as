package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	
	public class CouponExchangeDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const VIEW_CODE:String = "VIEW_CODE";
		public static const EXCHANGE:String = "EXCHANGE";
		
		public var closeButton:SimpleButton;
		public var leftButton:SimpleButton;
		public var rightButton:SimpleButton;
		
		public function CouponExchangeDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function setItemBox(boxList:Array){
			removeItemBox();
			var loop:int = 0;
			for each(var box:BuildItemBox in boxList){
				box.x = 70 * loop;
				box.y = 50;
				if(box is CouponExchangeItemBox1){
					box.addEventListener(MouseEvent.CLICK, onBox1Click);	
				} else {
					box.addEventListener(MouseEvent.CLICK, onBox2Click);	
				}
				this.addChild(box);
				loop++;
			}
		}
		
		private function removeItemBox(){
			var itemBox:Array = new Array();
			for(var i:int = 0; i < this.numChildren; i++){
				if((this.getChildAt(i) is CouponExchangeItemBox1) || 
								(this.getChildAt(i) is CouponExchangeItemBox2)){
					itemBox.push(this.getChildAt(i));
				}
			}
			for each(var box:BuildItemBox in itemBox){
				box.removeEventListener(MouseEvent.CLICK, onBox1Click);
				box.removeEventListener(MouseEvent.CLICK, onBox2Click);
				this.removeChild(box);
			}
		}
		
		public function onBox1Click(event:MouseEvent){
			this.dispatchEvent(new Event(EXCHANGE));
		}
		
		public function onBox2Click(event:MouseEvent){
			this.dispatchEvent(new Event(VIEW_CODE));
		}
	}
}