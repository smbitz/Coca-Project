package Resources {
	
	import flash.display.MovieClip;
	
	
	public class ShopDialog extends MovieClip {
		
		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const BUY:String = "BUY";
		public static const SELL:String = "SELL";
		
		public function ShopDialog() {
			// constructor code
		}
		
		//---- buyList : Array of ShopBuyItemBox ----//
		public function setBuyItemBox(buyList:Array){
			var i:int = 0;
			for each(var box:ShopBuyItemBox in buyList){
				box.x = 0;
				box.y = i * 50;
				this.addChild(box);
				i++;
			}
		}
		
		//---- buyList : Array of ShopSellItemBox ----//
		public function setSellItemBox(sellList:Array){
			var i:int = 0;
			for each(var box:ShopSellItemBox in sellList){
				box.x = 100;
				box.y = i * 50;
				this.addChild(box);
				i++;
			}
		}
	}
}