package Resources {
	
	import flash.display.MovieClip;
	import cocahappymachine.data.Building;
	import flash.text.TextField;
	
	
	public class BuildItemBox extends MovieClip {
		
		private static const ITEM_BUILD_COLOR:int = 0x0EA00A;
		private static const MONEY_BUILD_COLOR:int = 0x431D1E;
		private static const CANT_BUILD_COLOR:int = 0xFF3B00;
		private var id:String;
		private var isBuildable:Boolean;
		
		public var pictureMC:MovieClip;
		public var titleField:TextField;
		public var durationField:TextField;
		public var priceField:TextField;
		
		public function BuildItemBox() {
		}
		
		//---- set data Object using for identity building associate with BuildItemBox
		public function setBuildingId(id:String){
			this.id = id;
		}
		
		public function getBuildingId():String{
			return id;
		}
		
		public function setTitle(title:String){
			titleField.text = title;
		}
		
		public function setDuration(d:int){
			d = d / 60000;
			var minute:int = d % 60;
			var hour:int = d / 60;
			var minuteStr:String = minute.toString();
			var hourStr:String= hour.toString();
			if(minute < 10){
				minuteStr = "0" + minuteStr;
			}
			if(hour < 10){
				hourStr = "0" + hour;
			}
			durationField.text = hourStr + ":" + minuteStr + ":00";
		}
		
		public function setPrice(p:int, quantity:int, isEnoughMoney:Boolean){
			isBuildable = true;
			if(quantity > 0 ){
				priceField.text = "x " + quantity;
				priceField.textColor = ITEM_BUILD_COLOR;
			} else {
				priceField.text = p.toString();
				if(isEnoughMoney){
					priceField.textColor = MONEY_BUILD_COLOR;
				} else {
					priceField.textColor = CANT_BUILD_COLOR;
					isBuildable =false;
				}
			}
		}
		
		public function getBuildable():Boolean{
			return isBuildable;
		}
		
		public function setPicture(mc:MovieClip){
			while(pictureMC.numChildren != 0){
				pictureMC.removeChildAt(0);
			}
			pictureMC.addChild(mc);
		}
	}
}
