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
	import Resources.CE1ChineseCabbageItem;
	import Resources.CE1PumpkinItem;
	import Resources.CE1BabyCornItem;
	import Resources.CE1StrawMushroomsItem;
	import Resources.CE1ChickenItem;
	import Resources.CE1PigItem;
	import Resources.CE1CowItem;
	import Resources.CE1SheepItem;
	import Resources.CE1OstrichItem;
	import Resources.CE1FishItem;
	import Resources.CE1SquidItem;
	import Resources.CE1ScallopsItem;
	import Resources.CE1ShrimpItem;
	import Resources.CE1OysterItem;
	import Resources.CE2MorningGloryItem;
	import Resources.CE2ChineseCabbageItem;
	import Resources.CE2PumpkinItem;
	import Resources.CE2BabyCornItem;
	import Resources.CE2StrawMushroomsItem;
	import Resources.CE2PigItem;
	import Resources.CE2CowItem;
	import Resources.CE2SheepItem;
	import Resources.CE2OstrichItem;
	import Resources.CE2FishItem;
	import Resources.CE2SquidItem;
	import Resources.CE2ScallopsItem;
	import Resources.CE2ShrimpItem;
	import Resources.CE2OysterItem;
	import Resources.BuildChineseCabbageItem;
	import Resources.BuildPumpkinItem;
	import Resources.BuildBabyCornItem;
	import Resources.BuildStrawMushroomsItem;
	import Resources.BuildChickenItem;
	import Resources.BuildPigItem;
	import Resources.BuildCowItem;
	import Resources.BuildSheepItem;
	import Resources.BuildOstrichItem;
	import Resources.BuildFishItem;
	import Resources.BuildSquidItem;
	import Resources.BuildScallopsItem;
	import Resources.BuildShrimpItem;
	import Resources.BuildOysterItem;
	import Resources.AddItemMorningGloryItem;
	import Resources.AddItemChineseCabbageItem;
	import Resources.AddItemPumpkinItem;
	import Resources.AddItemBabyCornItem;
	import Resources.AddItemStrawMushroomsItem;
	import Resources.AddItemPigItem;
	import Resources.AddItemCowItem;
	import Resources.AddItemSheepItem;
	import Resources.AddItemOstrichItem;
	import Resources.AddItemFishItem;
	import Resources.AddItemSquidItem;
	import Resources.AddItemScallopsItem;
	import Resources.AddItemShrimpItem;
	import Resources.AddItemOysterItem;
	import Resources.AddItemSmallSappanWoodItem;
	import Resources.AddItemSmallPelletFoodItem;
	import Resources.AddItemSappanWoodEnableButton;
	import Resources.AddItemPelletFoodEnableButton;
	import Resources.AddItemVaccineAEnableButton;
	import Resources.AddItemMicroorganismAEnableButton;
	import Resources.AddItemVaccineBEnableButton;
	import Resources.AddItemMicroorganismBEnableButton;
	import Resources.ShopPearlItem;
	import Resources.ShopGoldItem;
	import Resources.ShopDiamondItem;
	import Resources.ShopSappanWoodItem;
	import Resources.ShopPelletFoodItem;
	import Resources.ShopMorningGloryItem;
	import Resources.ShopMorningGlorySeedItem;
	import Resources.ShopChineseCabbageSeedItem;
	import Resources.ShopPumpkinSeedItem;
	import Resources.ShopBabyCornSeedItem;
	import Resources.ShopStrawMushroomsSeedItem;
	import Resources.ShopChickenBabyItem;
	import Resources.ShopPigBabyItem;
	import Resources.ShopCowBabyItem;
	import Resources.ShopSheepBabyItem;
	import Resources.ShopOstrichBabyItem;
	import Resources.ShopFishBabyItem;
	import Resources.ShopSquidBabyItem;
	import Resources.ShopScallopsBabyItem;
	import Resources.ShopShrimpBabyItem;
	import Resources.ShopOysterBabyItem;
	import Resources.ShopChineseCabbageItem;
	import Resources.ShopPumpkinItem;
	import Resources.ShopBabyCornItem;
	import Resources.ShopChickenItem;
	import Resources.ShopPigItem;
	import Resources.ShopCowItem;
	import Resources.ShopSheepItem;
	import Resources.ShopOstrichItem;
	import Resources.ShopFishItem;
	import Resources.ShopSquidItem;
	import Resources.ShopScallopsItem;
	import Resources.ShopShrimpItem;
	import Resources.ShopOysterItem;
	import Resources.ShopStrawMushroomsItem;
	import Resources.AddItemWaterDisableButton;
	import Resources.AddItemSappanWoodDisableButton;
	import Resources.AddItemPelletFoodDisableButton;
	import Resources.AddItemFertilizerADisableButton;
	import Resources.AddItemVaccineADisableButton;
	import Resources.AddItemMicroorganismADisableButton;
	import Resources.AddItemFertilizerBDisableButton;
	import Resources.AddItemVaccineBDisableButton;
	import Resources.AddItemMicroorganismBDisableButton;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	
	public class ItemPictureBuilder {
		//Coupon Item id
		private static const COUPON_MORNING_GLORY_ID:String = "5010";
		private static const COUPON_CHINESE_CABBAGE_ID:String = "5020";
		private static const COUPON_PUMPKIN_ID:String = "5030";
		private static const COUPON_BABY_CORN_ID:String = "5040";
		private static const COUPON_STRAW_MUSHROOMS_ID:String = "5050";
		private static const COUPON_CHICKEN_ID:String = "5060";
		private static const COUPON_PIG_ID:String = "5070";
		private static const COUPON_COW_ID:String = "5080";
		private static const COUPON_SHEEP_ID:String = "5090";
		private static const COUPON_OSTRICH_ID:String = "50100";
		private static const COUPON_FISH_ID:String = "50110";
		private static const COUPON_SQUID_ID:String = "50120";
		private static const COUPON_SCALLOPS_ID:String = "50130";
		private static const COUPON_SHRIMP_ID:String = "50140";
		private static const COUPON_OYSTER_ID:String = "50150";
		
		//Buildind id
		private static const BUILDING_MORNING_GLORY_ID:String = "10";
		private static const BUILDING_CHINESE_CABBAGE_ID:String = "20";
		private static const BUILDING_PUMPKIN_ID:String = "30";
		private static const BUILDING_BABY_CORN_ID:String = "40";
		private static const BUILDING_STRAW_MUSHROOMS_ID:String = "50";
		private static const BUILDING_CHICKEN_ID:String = "60";
		private static const BUILDING_PIG_ID:String = "70";
		private static const BUILDING_COW_ID:String = "80";
		private static const BUILDING_SHEEP_ID:String = "90";
		private static const BUILDING_OSTRICH_ID:String = "100";
		private static const BUILDING_FISH_ID:String = "110";
		private static const BUILDING_SQUID_ID:String = "120";
		private static const BUILDING_SCALLOPS_ID:String = "130";
		private static const BUILDING_SHRIMP_ID:String = "140";
		private static const BUILDING_OYSTER_ID:String = "150";
		
		//Item Id
		private static const ITEM_MORNING_GLORY_SEED_ID:String = "10";
		private static const ITEM_CHINESE_CABBAGE_SEED_ID:String = "20";
		private static const ITEM_PUMPKIN_SEED_ID:String = "30";
		private static const ITEM_BABY_CORN_SEED_ID:String = "40";
		private static const ITEM_STRAW_MUSHROOMS_SEED_ID:String = "50";
		private static const ITEM_CHICKEN_BABY_ID:String = "60";
		private static const ITEM_PIG_BABY_ID:String = "70";
		private static const ITEM_COW_BABY_ID:String = "80";
		private static const ITEM_SHEEP_BABY_ID:String = "90";
		private static const ITEM_OSTRICH_BABY_ID:String = "100";
		private static const ITEM_FISH_BABY_ID:String = "110";
		private static const ITEM_SQUID_BABY_ID:String = "120";
		private static const ITEM_SCALLOPS_BABY_ID:String = "130";
		private static const ITEM_SHRIMP_BABY_ID:String = "140";
		private static const ITEM_OYSTER_BABY_ID:String = "150";
		private static const ITEM_WATER_ID:String = "160";
		private static const ITEM_FANG_DRY_ID:String = "170";
		private static const ITEM_PELLET_FOOD_ID:String = "180";
		private static const ITEM_PEARL_ID:String = "190";
		private static const ITEM_GOLD_ID:String = "200";
		private static const ITEM_DIAMOND_ID:String = "210";
		private static const ITEM_MORNING_GLORY_ID:String = "220";
		private static const ITEM_CHINESE_CABBAGE_ID:String = "230";
		private static const ITEM_PUMPKIN_ID:String = "240";
		private static const ITEM_BABY_CORN_ID:String = "250";
		private static const ITEM_STRAW_MUSHROOMS_ID:String = "260";
		private static const ITEM_CHICKEN_ID:String = "270";
		private static const ITEM_PIG_ID:String = "280";
		private static const ITEM_COW_ID:String = "290";
		private static const ITEM_SHEEP_ID:String = "300";
		private static const ITEM_OSTRICH_ID:String = "310";
		private static const ITEM_FISH_ID:String = "320";
		private static const ITEM_SQUID_ID:String = "330";
		private static const ITEM_SCALLOPS_ID:String = "340";
		private static const ITEM_SHRIMP_ID:String = "350";
		private static const ITEM_OYSTER_ID:String = "360";
		
		//Building Type
		private static const BUILD_TYPE_VAGE:String = "vege";
		private static const BUILD_TYPE_MEAT:String = "meat";
		private static const BUILD_TYPE_SEA:String = "sea";
		
		public function ItemPictureBuilder() {
			// constructor code
		}

		public static function createCouponExchangeItemBox1Picture(item:Item):MovieClip {
			if(item.getId()==COUPON_MORNING_GLORY_ID){
				return new CE1MorningGloryItem();
			}else if(item.getId()==COUPON_CHINESE_CABBAGE_ID){
				return new CE1ChineseCabbageItem();
			}else if(item.getId()==COUPON_PUMPKIN_ID){
				return new CE1PumpkinItem();
			}else if(item.getId()==COUPON_BABY_CORN_ID){
				return new CE1BabyCornItem();
			}else if(item.getId()==COUPON_STRAW_MUSHROOMS_ID){
				return new CE1StrawMushroomsItem();
			}else if(item.getId()==COUPON_CHICKEN_ID){
				return new CE1ChickenItem();
			}else if(item.getId()==COUPON_PIG_ID){
				return new CE1PigItem();
			}else if(item.getId()==COUPON_COW_ID){
				return new CE1CowItem();
			}else if(item.getId()==COUPON_SHEEP_ID){
				return new CE1SheepItem();
			}else if(item.getId()==COUPON_OSTRICH_ID){
				return new CE1OstrichItem();
			}else if(item.getId()==COUPON_FISH_ID){
				return new CE1FishItem();
			}else if(item.getId()==COUPON_SQUID_ID){
				return new CE1SquidItem();
			}else if(item.getId()==COUPON_SCALLOPS_ID){
				return new CE1ScallopsItem();
			}else if(item.getId()==COUPON_SHRIMP_ID){
				return new CE1ShrimpItem();
			}else if(item.getId()==COUPON_OYSTER_ID){
				return new CE1OysterItem();
			}
			
			return new null;
		}
		
		public static function createCouponExchangeItemBox2Picture(item:Item):MovieClip {
			if(item.getId()==COUPON_MORNING_GLORY_ID){
				return new CE2MorningGloryItem();
			}else if(item.getId()==COUPON_CHINESE_CABBAGE_ID){
				return new CE2ChineseCabbageItem();
			}else if(item.getId()==COUPON_PUMPKIN_ID){
				return new CE2PumpkinItem();
			}else if(item.getId()==COUPON_BABY_CORN_ID){
				return new CE2BabyCornItem();
			}else if(item.getId()==COUPON_STRAW_MUSHROOMS_ID){
				return new CE2StrawMushroomsItem();
			}else if(item.getId()==COUPON_CHICKEN_ID){
				return new CE2ChickenItem();
			}else if(item.getId()==COUPON_PIG_ID){
				return new CE2PigItem();
			}else if(item.getId()==COUPON_COW_ID){
				return new CE2CowItem();
			}else if(item.getId()==COUPON_SHEEP_ID){
				return new CE2SheepItem();
			}else if(item.getId()==COUPON_OSTRICH_ID){
				return new CE2OstrichItem();
			}else if(item.getId()==COUPON_FISH_ID){
				return new CE2FishItem();
			}else if(item.getId()==COUPON_SQUID_ID){
				return new CE2SquidItem();
			}else if(item.getId()==COUPON_SCALLOPS_ID){
				return new CE2ScallopsItem();
			}else if(item.getId()==COUPON_SHRIMP_ID){
				return new CE2ShrimpItem();
			}else if(item.getId()==COUPON_OYSTER_ID){
				return new CE2OysterItem();
			}
			
			return new null;
		}

		public static function createCouponExchangeItemBox3Picture(item:Item):MovieClip {
			if(item.getId()==COUPON_MORNING_GLORY_ID){
				return new CE2MorningGloryItem();
			}else if(item.getId()==COUPON_CHINESE_CABBAGE_ID){
				return new CE2ChineseCabbageItem();
			}else if(item.getId()==COUPON_PUMPKIN_ID){
				return new CE2PumpkinItem();
			}else if(item.getId()==COUPON_BABY_CORN_ID){
				return new CE2BabyCornItem();
			}else if(item.getId()==COUPON_STRAW_MUSHROOMS_ID){
				return new CE2StrawMushroomsItem();
			}else if(item.getId()==COUPON_CHICKEN_ID){
				return new CE2ChickenItem();
			}else if(item.getId()==COUPON_PIG_ID){
				return new CE2PigItem();
			}else if(item.getId()==COUPON_COW_ID){
				return new CE2CowItem();
			}else if(item.getId()==COUPON_SHEEP_ID){
				return new CE2SheepItem();
			}else if(item.getId()==COUPON_OSTRICH_ID){
				return new CE2OstrichItem();
			}else if(item.getId()==COUPON_FISH_ID){
				return new CE2FishItem();
			}else if(item.getId()==COUPON_SQUID_ID){
				return new CE2SquidItem();
			}else if(item.getId()==COUPON_SCALLOPS_ID){
				return new CE2ScallopsItem();
			}else if(item.getId()==COUPON_SHRIMP_ID){
				return new CE2ShrimpItem();
			}else if(item.getId()==COUPON_OYSTER_ID){
				return new CE2OysterItem();
			}
			
			return new null;
		}
		
		public static function createBuildItemBoxPicture(building:Building):MovieClip {
			if(building.getId()==BUILDING_MORNING_GLORY_ID){
				return new BuildMorningGloryItem();
			}else if(building.getId()==BUILDING_CHINESE_CABBAGE_ID){
				return new BuildChineseCabbageItem();
			}else if(building.getId()==BUILDING_PUMPKIN_ID){
				return new BuildPumpkinItem();
			}else if(building.getId()==BUILDING_BABY_CORN_ID){
				return new BuildBabyCornItem();
			}else if(building.getId()==BUILDING_STRAW_MUSHROOMS_ID){
				return new BuildStrawMushroomsItem();
			}else if(building.getId()==BUILDING_CHICKEN_ID){
				return new BuildChickenItem();
			}else if(building.getId()==BUILDING_PIG_ID){
				return new BuildPigItem();
			}else if(building.getId()==BUILDING_COW_ID){
				return new BuildCowItem();
			}else if(building.getId()==BUILDING_SHEEP_ID){
				return new BuildSheepItem();
			}else if(building.getId()==BUILDING_OSTRICH_ID){
				return new BuildOstrichItem();
			}else if(building.getId()==BUILDING_FISH_ID){
				return new BuildFishItem();
			}else if(building.getId()==BUILDING_SQUID_ID){
				return new BuildSquidItem();
			}else if(building.getId()==BUILDING_SCALLOPS_ID){
				return new BuildScallopsItem();
			}else if(building.getId()==BUILDING_SHRIMP_ID){
				return new BuildShrimpItem();
			}else if(building.getId()==BUILDING_OYSTER_ID){
				return new BuildOysterItem();
			}
			
			return null;
		}
		
		public static function createAddItemBoxPicture(building:Building):MovieClip{
			if(building.getId()==BUILDING_MORNING_GLORY_ID){
				return new AddItemMorningGloryItem();
			}else if(building.getId()==BUILDING_CHINESE_CABBAGE_ID){
				return new AddItemChineseCabbageItem();
			}else if(building.getId()==BUILDING_PUMPKIN_ID){
				return new AddItemPumpkinItem();
			}else if(building.getId()==BUILDING_BABY_CORN_ID){
				return new AddItemBabyCornItem();
			}else if(building.getId()==BUILDING_STRAW_MUSHROOMS_ID){
				return new AddItemStrawMushroomsItem();
			}else if(building.getId()==BUILDING_CHICKEN_ID){
				return new AddItemChickenItem();
			}else if(building.getId()==BUILDING_PIG_ID){
				return new AddItemPigItem();
			}else if(building.getId()==BUILDING_COW_ID){
				return new AddItemCowItem();
			}else if(building.getId()==BUILDING_SHEEP_ID){
				return new AddItemSheepItem();
			}else if(building.getId()==BUILDING_OSTRICH_ID){
				return new AddItemOstrichItem();
			}else if(building.getId()==BUILDING_FISH_ID){
				return new AddItemFishItem();
			}else if(building.getId()==BUILDING_SQUID_ID){
				return new AddItemSquidItem();
			}else if(building.getId()==BUILDING_SCALLOPS_ID){
				return new AddItemScallopsItem();
			}else if(building.getId()==BUILDING_SHRIMP_ID){
				return new AddItemShrimpItem();
			}else if(building.getId()==BUILDING_OYSTER_ID){
				return new AddItemOysterItem();
			}
			
			return null;
		}
		
		public static function createShopItemBoxPicture(item:Item):MovieClip{
			if(item.getId()==ITEM_MORNING_GLORY_SEED_ID){
				return new ShopMorningGlorySeedItem();
			}else if(item.getId()==ITEM_CHINESE_CABBAGE_SEED_ID){
				return new ShopChineseCabbageSeedItem();
			}else if(item.getId()==ITEM_PUMPKIN_SEED_ID){
				return new ShopPumpkinSeedItem();
			}else if(item.getId()==ITEM_BABY_CORN_SEED_ID){
				return new ShopBabyCornSeedItem();
			}else if(item.getId()==ITEM_STRAW_MUSHROOMS_SEED_ID){
				return new ShopStrawMushroomsSeedItem();
			}else if(item.getId()==ITEM_CHICKEN_BABY_ID){
				return new ShopChickenBabyItem();
			}else if(item.getId()==ITEM_PIG_BABY_ID){
				return new ShopPigBabyItem();
			}else if(item.getId()==ITEM_COW_BABY_ID){
				return new ShopCowBabyItem();
			}else if(item.getId()==ITEM_SHEEP_BABY_ID){
				return new ShopSheepBabyItem();
			}else if(item.getId()==ITEM_OSTRICH_BABY_ID){
				return new ShopOstrichBabyItem();
			}else if(item.getId()==ITEM_FISH_BABY_ID){
				return new ShopFishBabyItem();
			}else if(item.getId()==ITEM_SQUID_BABY_ID){
				return new ShopSquidBabyItem();
			}else if(item.getId()==ITEM_SCALLOPS_BABY_ID){
				return new ShopScallopsBabyItem();
			}else if(item.getId()==ITEM_SHRIMP_BABY_ID){
				return new ShopShrimpBabyItem();
			}else if(item.getId()==ITEM_OYSTER_BABY_ID){
				return new ShopOysterBabyItem();
			}else if(item.getId()==ITEM_WATER_ID){
				return new ShopWaterItem();
			}else if(item.getId()==ITEM_FANG_DRY_ID){
				return new ShopSappanWoodItem();
			}else if(item.getId()==ITEM_PELLET_FOOD_ID){
				return new ShopPelletFoodItem();
			}else if(item.getId()==ITEM_PEARL_ID){
				return new ShopPearlItem();
			}else if(item.getId()==ITEM_GOLD_ID){
				return new ShopGoldItem();
			}else if(item.getId()==ITEM_DIAMOND_ID){
				return new ShopDiamondItem();
			}else if(item.getId()==ITEM_MORNING_GLORY_ID){
				return new ShopMorningGloryItem();
			}else if(item.getId()==ITEM_CHINESE_CABBAGE_ID){
				return new ShopChineseCabbageItem();
			}else if(item.getId()==ITEM_PUMPKIN_ID){
				return new ShopPumpkinItem();
			}else if(item.getId()==ITEM_BABY_CORN_ID){
				return new ShopBabyCornItem();
			}else if(item.getId()==ITEM_STRAW_MUSHROOMS_ID){
				return new ShopStrawMushroomsItem();
			}else if(item.getId()==ITEM_CHICKEN_ID){
				return new ShopChickenItem();
			}else if(item.getId()==ITEM_PIG_ID){
				return new ShopPigItem();
			}else if(item.getId()==ITEM_COW_ID){
				return new ShopCowItem();
			}else if(item.getId()==ITEM_SHEEP_ID){
				return new ShopSheepItem();
			}else if(item.getId()==ITEM_OSTRICH_ID){
				return new ShopOstrichItem();
			}else if(item.getId()==ITEM_FISH_ID){
				return new ShopFishItem();
			}else if(item.getId()==ITEM_SQUID_ID){
				return new ShopSquidItem();
			}else if(item.getId()==ITEM_SCALLOPS_ID){
				return new ShopScallopsItem();
			}else if(item.getId()==ITEM_SHRIMP_ID){
				return new ShopShrimpItem();
			}else if(item.getId()==ITEM_OYSTER_ID){
				return new ShopOysterItem();
			}
			
			return null;
		}
		
		public static function createAddItemSmallPicture(building:Building):MovieClip{
			if(building.getBuildingType()==BUILD_TYPE_VAGE){
				return new AddItemSmallWaterItem();
			}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
				return new AddItemSmallSappanWoodItem();
			}else if(building.getBuildingType()==BUILD_TYPE_SEA){
				return new AddItemSmallPelletFoodItem();
			}
			
			return null;
		}
		
		public static function createAddItemSupplyButton(building:Building, isSupply:Boolean){
			if(isSupply){
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemWaterEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemSappanWoodEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemPelletFoodEnableButton();
				}
			}else{
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemWaterDisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemSappanWoodDisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemPelletFoodDisableButton();
				}
			}
			return null;
		}
		
		public static function createAddItemExtra1Button(building:Building, isExtra1:Boolean){
			if(isExtra1){
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemFertilizerAEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemVaccineAEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemMicroorganismAEnableButton();
				}
			}else{
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemFertilizerADisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemVaccineADisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemMicroorganismADisableButton();
				}
			}
			
			return null;
		}
		
		public static function createAddItemExtra2Button(building:Building, isExtra2:Boolean){
			if(isExtra2){
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemFertilizerBEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemVaccineBEnableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemMicroorganismBEnableButton();
				}
			}else{
				if(building.getBuildingType()==BUILD_TYPE_VAGE){
					return new AddItemFertilizerBDisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_MEAT){
					return new AddItemVaccineBDisableButton();
				}else if(building.getBuildingType()==BUILD_TYPE_SEA){
					return new AddItemMicroorganismBDisableButton();
				}
			}
			
			return null;
		}
		
		public static function createItemGetPicture(itemID:String):DisplayObject{
			var d: DisplayObject = new AddItemFertilizerBEnableButton();
			return d;
		}
	}
}
