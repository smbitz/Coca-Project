﻿package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import cocahappymachine.ui.CouponEvent;
	import flash.text.TextField;
	
	public class CouponExchangeDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const VIEW_CODE:String = "VIEW_CODE";
		public static const EXCHANGE:String = "EXCHANGE";
		
		public var closeButton:SimpleButton;
		public var leftButton:SimpleButton;
		public var rightButton:SimpleButton;
		
		public var allTab:TextField;
		public var availableTab:TextField;
		public var unavailableTab:TextField;
		public var myTab:TextField;
		
		public var allCouponsSelected:SimpleButton;
		public var allCouponsUnselected:SimpleButton;
		public var availableSelected:SimpleButton;
		public var availableUnselected:SimpleButton;
		public var unavailableSelected:SimpleButton;
		public var unavailableUnselected:SimpleButton;
		public var myCouponsSelected:SimpleButton;
		public var myCouponsUnselected:SimpleButton;
		
		public var tabContent:MovieClip;
		
		public function CouponExchangeDialog() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event){
			if(this.totalFrames == this.currentFrame){
				this.stop();
			}
		}
		
		public function getAllCouponsSelectedButton():SimpleButton{
			return allCouponsSelected;
		}
		
		public function getAllCouponUnselectedButton():SimpleButton{
			return allCouponsUnselected;
		}
		
		public function getAvailableSelectedButton():SimpleButton{
			return availableSelected;
		}
		
		public function getAvailableUnselectedButton():SimpleButton{
			return availableUnselected;
		}
		
		public function getUnavailableSelectedButton():SimpleButton{
			return unavailableSelected;
		}
		
		public function getUnavailableUnselectedButton():SimpleButton{
			return unavailableUnselected;
		}
		
		public function getMyCouponsSelectedButton():SimpleButton{
			return myCouponsSelected;
		}
		
		public function getMyCouponsUnselectedButton():SimpleButton{
			return myCouponsUnselected;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function setItemBox(boxList:Array){
			removeItemBox();
			var loop:int = 0;
			for each(var box:MovieClip in boxList){
				if(box is CouponExchangeItemBox1){
				} else if (box is CouponExchangeItemBox2){
					box.addEventListener(MouseEvent.CLICK, onBox2Click);	
				} else if (box is CouponExchangeItemBox3){
					box.addEventListener(MouseEvent.CLICK, onBox3Click);	
				}
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
				box.removeEventListener(MouseEvent.CLICK, onBox2Click);
				box.removeEventListener(MouseEvent.CLICK, onBox3Click);
			}
		}
		
		public function onBox1Click(event:MouseEvent){
			/*
			trace("box1");
			var e:CouponEvent = new CouponEvent(EXCHANGE)
			if(event.target is CouponExchangeItemBox1){
				var box:CouponExchangeItemBox1 = CouponExchangeItemBox1(event.target);
				e.setItemId(box.getItemId());
			} else {
				throw new Error("unexpected : onBox1Click in CouponExchangeDialog.as");
			}
			this.dispatchEvent(e);
			*/
		}
		
		public function onBox2Click(event:MouseEvent){
			trace("box2");
			var e:CouponEvent = new CouponEvent(EXCHANGE)
			if(event.currentTarget is CouponExchangeItemBox2){
				var box:CouponExchangeItemBox2 = CouponExchangeItemBox2(event.currentTarget);				
				e.setItemId(box.getItemId());
			} else {
				throw new Error("unexpected : onBox2Click in CouponExchangeDialog.as");
			}
			this.dispatchEvent(e);
		}
		
		public function onBox3Click(event:MouseEvent){
			trace("box3");
			var e:CouponEvent = new CouponEvent(VIEW_CODE)
			if(event.currentTarget is CouponExchangeItemBox3){
				var box:CouponExchangeItemBox3 = CouponExchangeItemBox3(event.currentTarget);
				e.setItemId(box.getItemId());
			} else {
				throw new Error("unexpected : onBox3Click in CouponExchangeDialog.as");
			}
			this.dispatchEvent(e);
		}
		
		public function addTabContent(mc:MovieClip){
			tabContent.addChild(mc);
		}
	}
}