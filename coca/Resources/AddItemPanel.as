package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import cocahappymachine.data.Tile;
	import flash.text.TextField;
	
	public class AddItemPanel extends MovieClip {

		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const SUPPLYITEM_CLICK:String = "SUPPLYITEM_CLICK";
		public static const EXTRAITEM1_CLICK:String = "EXTRAITEM1_CLICK";
		public static const EXTRAITEM2_CLICK:String = "EXTRAITEM2_CLICK";
		public static const MOVE_CLICK:String = "MOVE_CLICK";

		public var closePane:MovieClip;
		public var pictureMC:MovieClip;
		public var smallPictureMC:MovieClip;
		public var closeButton:SimpleButton;
		public var supplyItemButton:MovieClip;
		public var extraItem1Button:MovieClip;
		public var extraItem2Button:MovieClip;
		public var moveButton:MoveButton;
		public var nameField:TextField;
		public var progressField:TextField;
		public var supplyField:TextField;
		
		public function AddItemPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			closePane.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			moveButton.addEventListener(MouseEvent.CLICK, onMoveClick);
		}
		
		public function setName(name:String){
			nameField.text = name;
		}
		
		public function setProgress(progress:int){
			progress = progress / 1000;
			var second:int = progress % 60;
			progress = progress / 60;
			var minute:int = progress % 60;
			var hour:int = progress / 60;
			var secondStr:String = second.toString();
			var minuteStr:String = minute.toString();
			var hourStr:String= hour.toString();
			if(minute < 10){
				minuteStr = "0" + minuteStr;
			}
			if(hour < 10){
				hourStr = "0" + hour;
			}
			if(second < 10){
				secondStr = "0" + second;
			}
			progressField.text = hourStr + ":" + minuteStr + ":" + secondStr;
		}
		
		public function setSupply(supplyPercentage:Number){
			supplyField.text = (supplyPercentage * 100).toFixed(2) + "%";
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			if(event.currentTarget == event.target){
				this.dispatchEvent(new Event(DIALOG_CLOSE));
			}
		}
		
		public function onSupplyItemClick(event:MouseEvent){
			this.dispatchEvent(new Event(SUPPLYITEM_CLICK));
		}
		
		public function onExtraItem1Click(event:MouseEvent){
			this.dispatchEvent(new Event(EXTRAITEM1_CLICK));
		}
		
		public function onExtraItem2Click(event:MouseEvent){
			this.dispatchEvent(new Event(EXTRAITEM2_CLICK));
		}
		
		public function onMoveClick(event:MouseEvent){
			this.dispatchEvent(new Event(MOVE_CLICK));
		}
		
		public function setPicture(mc:MovieClip){
			while(pictureMC.numChildren != 0){
				pictureMC.removeChildAt(0);
			}
			pictureMC.addChild(mc);
		}
		
		public function setSmallPicture(mc:MovieClip){
			while(smallPictureMC.numChildren != 0){
				smallPictureMC.removeChildAt(0);
			}
			smallPictureMC.addChild(mc);
		}
		
		public function setSupplyButton(mc:SimpleButton, isEnable:Boolean){
			while(supplyItemButton.numChildren != 0){
				supplyItemButton.getChildAt(0).removeEventListener(MouseEvent.CLICK, onSupplyItemClick);
				supplyItemButton.removeChildAt(0);
			}
			if(isEnable){
				mc.addEventListener(MouseEvent.CLICK, onSupplyItemClick);
			}
			supplyItemButton.addChild(mc);
		}
		
		public function setExtra1Button(mc:SimpleButton, isEnable:Boolean){
			while(extraItem1Button.numChildren != 0){
				extraItem1Button.getChildAt(0).removeEventListener(MouseEvent.CLICK, onExtraItem1Click);
				extraItem1Button.removeChildAt(0);
			}
			if(isEnable){
				mc.addEventListener(MouseEvent.CLICK, onExtraItem1Click);
			}
			extraItem1Button.addChild(mc);
		}
		
		public function setExtra2Button(mc:SimpleButton, isEnable:Boolean){
			while(extraItem2Button.numChildren != 0){
				extraItem2Button.getChildAt(0).removeEventListener(MouseEvent.CLICK, onExtraItem2Click);
				extraItem2Button.removeChildAt(0);
			}
			if(isEnable){
				mc.addEventListener(MouseEvent.CLICK, onExtraItem2Click);
			}
			extraItem2Button.addChild(mc);
		}
	}
}