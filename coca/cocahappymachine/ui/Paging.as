package cocahappymachine.ui {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class Paging extends MovieClip {

		private var itemList:Array;
		private var itemPerPageHorizontal:int;
		private var itemPerPageVertical:int;
		private var xGap:int;
		private var yGap:int;
		private var currentPage:int;
		
		private var leftButton:SimpleButton;
		private var rightButton:SimpleButton;
		private var maskMC:MovieClip;
		
		public function Paging() {
			maskMC = new MovieClip();
			this.addChild(maskMC);
			this.mask = maskMC;
		}
		
		public function setItem(itemList:Array){
			if(this.itemList != null){
				for each(var removeMC:MovieClip in this.itemList){
					this.removeChild(removeMC);
				}
			}
			this.itemList = itemList;
			for each(var mc:MovieClip in itemList){
				this.addChild(mc);
			}
			calculate();
		}
		
		public function setItemPerPage(h:int, v:int){
			itemPerPageHorizontal = h;
			itemPerPageVertical = v;
			calculate();
		}
		
		public function setGap(xGap:int, yGap:int){
			this.xGap = xGap;
			this.yGap = yGap;
			calculate();
		}
		
		public function setLeftRightButton(lButton:SimpleButton, rButton:SimpleButton){
			leftButton = lButton;
			rightButton = rButton;
			leftButton.addEventListener(MouseEvent.CLICK, onLeft);
			rightButton.addEventListener(MouseEvent.CLICK, onRight);
			calculate();
		}

		public function setCurrentPage(page:int){
			currentPage = page;
			calculate();
		}
		
		private function calculate(){
			var pageSize:int = xGap * itemPerPageHorizontal;
			var ySize:int = yGap * itemPerPageVertical;
			if(itemList != null){
				var pageNum:int = 0;
				var xCount:int = 0;
				var yCount:int = 0;
				for each(var mc:MovieClip in itemList){
					mc.x = (pageNum * pageSize) + (xGap * xCount) - (currentPage * pageSize);
					mc.y = yGap * yCount;
					xCount++;
					if(xCount >= itemPerPageHorizontal){
						xCount = xCount - itemPerPageHorizontal;
						yCount++;
					}
					if(yCount >= itemPerPageVertical){
						pageNum++;
						yCount = yCount - itemPerPageVertical;
					}
				}
				if((leftButton != null) && (rightButton != null)){
					if(currentPage == 0){
						leftButton.visible = false;
					} else {
						leftButton.visible = true;
					}
					var maxPage:int = getMaxPage();
					currentPage = Math.min(currentPage, maxPage);
					if(currentPage == maxPage){
						rightButton.visible = false;
					} else {
						rightButton.visible = true;
					}
				}
				this.removeChild(maskMC);
				maskMC = new MovieClip();
				maskMC.graphics.beginFill(0x000000, 1);
				maskMC.graphics.drawRect(0, 0, pageSize, ySize);
				maskMC.graphics.endFill();
				this.addChild(maskMC);
				this.mask = maskMC;
			}

		}
		
		public function onLeft(event:MouseEvent){
			currentPage--;
			currentPage = Math.max(0, currentPage);
			calculate();
		}
		
		public function onRight(event:MouseEvent){
			currentPage++;
			var maxPage:int = getMaxPage();
			currentPage = Math.min(currentPage, maxPage);
			calculate();
		}
		
		public function getMaxPage():int{
			return itemList.length / (itemPerPageHorizontal * itemPerPageVertical)
		}
		
	}
}