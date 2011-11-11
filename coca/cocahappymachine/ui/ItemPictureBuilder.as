﻿package cocahappymachine.ui {
	import cocahappymachine.data.Item;
	import flash.display.MovieClip;
	import Resources.CE1MorningGloryItem;
	import Resources.MoveButton;
	import Resources.CE2ChickenItem;
	
	public class ItemPictureBuilder {

		public function ItemPictureBuilder() {
			// constructor code
		}

		public static function createCouponExchangeItemBox1Picture(item:Item):MovieClip {
			return new CE1MorningGloryItem();
		}
		
		public static function createCouponExchangeItemBox2Picture(item:Item):MovieClip {
			return new CE2ChickenItem();
		}
	}
	
}
