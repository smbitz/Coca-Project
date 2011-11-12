package cocahappymachine.ui {
	import cocahappymachine.data.Item;
	import flash.display.MovieClip;
	import Resources.CE1MorningGloryItem;
	import Resources.MoveButton;
	import Resources.CE2ChickenItem;
	import cocahappymachine.data.Building;
	import Resources.BuildMorningGloryItem;
	import Resources.AddItemChickenItem;
	import Resources.ShopWaterItem;
	import Resources.AddItemSmallWaterItem;
	import Resources.AddItemWaterEnableButton;
	import Resources.AddItemFertilizerAEnableButton;
	import Resources.AddItemFertilizerBEnableButton;
	
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

		public static function createCouponExchangeItemBox3Picture(item:Item):MovieClip {
			return new CE2ChickenItem();
		}
		
		public static function createBuildItemBoxPicture(buliding:Building):MovieClip {
			return new BuildMorningGloryItem();
		}
		
		public static function createAddItemBoxPicture(building:Building):MovieClip{
			return new AddItemChickenItem();
		}
		
		public static function createShopItemBoxPicture(item:Item):MovieClip{
			return new ShopWaterItem();
		}
		
		public static function createAddItemSmallPicture(building:Building):MovieClip{
			return new AddItemSmallWaterItem();
		}
		
		public static function createAddItemSupplyButton(building:Building, isSupply:Boolean){
			return new AddItemWaterEnableButton();
		}
		
		public static function createAddItemExtra1Button(building:Building, isExtra1:Boolean){
			return new AddItemFertilizerAEnableButton();
		}
		
		public static function createAddItemExtra2Button(building:Building, isExtra2:Boolean){
			return new AddItemFertilizerBEnableButton();
		}
	}
}
