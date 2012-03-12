package cocahappymachine.ui {
	import cocahappymachine.data.Tile;
	import Resources.EmptyFarmTile;
	import Resources.MorningGlory1Tile;
	import Resources.MorningGlory2Tile;
	import Resources.MorningGlory3Tile;
	import Resources.MorningGlory4Tile;
	import Resources.ChineseCabbage1Tile;
	import Resources.ChineseCabbage2Tile;
	import Resources.ChineseCabbage3Tile;
	import Resources.ChineseCabbage4Tile;
	import Resources.Pumpkin1Tile;
	import Resources.Pumpkin2Tile;
	import Resources.Pumpkin3Tile;
	import Resources.Pumpkin4Tile;
	import Resources.BabyCorn1Tile;
	import Resources.BabyCorn2Tile;
	import Resources.BabyCorn3Tile;
	import Resources.BabyCorn4Tile;
	import Resources.StrawMushrooms1Tile;
	import Resources.StrawMushrooms2Tile;
	import Resources.StrawMushrooms3Tile;
	import Resources.StrawMushrooms4Tile;
	import Resources.Chicken1Tile;
	import Resources.Chicken2Tile;
	import Resources.Chicken3Tile;
	import Resources.Chicken4Tile;
	import Resources.Pig1Tile;
	import Resources.Pig2Tile;
	import Resources.Pig3Tile;
	import Resources.Pig4Tile;
	import Resources.Cow1Tile;
	import Resources.Cow2Tile;
	import Resources.Cow3Tile;
	import Resources.Cow4Tile;
	import Resources.Sheep1Tile;
	import Resources.Sheep2Tile;
	import Resources.Sheep3Tile;
	import Resources.Sheep4Tile;
	import Resources.Ostrich1Tile;
	import Resources.Ostrich2Tile;
	import Resources.Ostrich3Tile;
	import Resources.Ostrich4Tile;
	import Resources.Fish1Tile;
	import Resources.Fish2Tile;
	import Resources.Fish3Tile;
	import Resources.Fish4Tile;
	import Resources.Squid1Tile;
	import Resources.Squid2Tile;
	import Resources.Squid3Tile;
	import Resources.Squid4Tile;
	import Resources.Scallops1Tile;
	import Resources.Scallops2Tile;
	import Resources.Scallops3Tile;
	import Resources.Scallops4Tile;
	import Resources.Shrimp1Tile;
	import Resources.Shrimp2Tile;
	import Resources.Shrimp3Tile;
	import Resources.Shrimp4Tile;
	import Resources.Oyster1Tile;
	import Resources.Oyster2Tile;
	import Resources.Oyster3Tile;
	import Resources.Oyster4Tile;
	
	public class FarmTileBuilder {
		
		private static const BUILDING_MORNING_GLORY_ID = "10";
		private static const BUILDING_CHINESE_CABBAGE_ID = "20";
		private static const BUILDING_PUMPKIN_ID = "30";
		private static const BUILDING_BABY_CORN_ID = "40";
		private static const BUILDING_STRAW_MUSHROOMS_ID = "50";
		private static const BUILDING_CHICKEN_ID = "60";
		private static const BUILDING_PIG_ID = "70";
		private static const BUILDING_COW_ID = "80";
		private static const BUILDING_SHEEP_ID = "90";
		private static const BUILDING_OSTRICH_ID = "100";
		private static const BUILDING_FISH_ID = "110";
		private static const BUILDING_SQUID_ID = "120";
		private static const BUILDING_SCALLOPS_ID = "130";
		private static const BUILDING_SHRIMP_ID = "140";
		private static const BUILDING_OYSTER_ID = "150";
		
		public function FarmTileBuilder() {
			// constructor code
		}

		public static function createFarmTile(tileData:Tile):AbstractFarmTile{
			if(tileData.getBuildingStatus() == Tile.BUILDING_NOTOCCUPY){
				return new EmptyFarmTile();
			} else if(tileData.getBuildingStatus() == Tile.BUILDING_EMPTY){
				return new EmptyFarmTile();
			} else if(tileData.getBuildingId() == BUILDING_MORNING_GLORY_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new MorningGlory1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new MorningGlory2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new MorningGlory3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new MorningGlory4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_CHINESE_CABBAGE_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new ChineseCabbage1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new ChineseCabbage2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new ChineseCabbage3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new ChineseCabbage4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_PUMPKIN_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Pumpkin1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Pumpkin2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Pumpkin3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Pumpkin4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_BABY_CORN_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new BabyCorn1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new BabyCorn2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new BabyCorn3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new BabyCorn4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_STRAW_MUSHROOMS_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new StrawMushrooms1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new StrawMushrooms2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new StrawMushrooms3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new StrawMushrooms4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_CHICKEN_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					var newChicken1Tile:Chicken1Tile = new Chicken1Tile();
					newChicken1Tile.gotoAndPlay( int(Math.random()*100) );
					return newChicken1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					var newChicken2Tile:Chicken2Tile = new Chicken2Tile();
					newChicken2Tile.gotoAndPlay( int(Math.random()*100) );
					return newChicken2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					var newChicken3Tile:Chicken3Tile = new Chicken3Tile();
					newChicken3Tile.gotoAndPlay( int(Math.random()*100) );
					return newChicken3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					var newChicken4Tile:Chicken4Tile = new Chicken4Tile();
					newChicken4Tile.gotoAndPlay( int(Math.random()*100) );
					return newChicken4Tile;
				}
			} else if(tileData.getBuildingId() == BUILDING_PIG_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					var newPig1Tile:Pig1Tile = new Pig1Tile();
					newPig1Tile.gotoAndPlay( int(Math.random()*100) );
					return newPig1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					var newPig2Tile:Pig2Tile = new Pig2Tile();
					newPig2Tile.gotoAndPlay( int(Math.random()*100) );
					return newPig2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					var newPig3Tile:Pig3Tile = new Pig3Tile();
					newPig3Tile.gotoAndPlay( int(Math.random()*100) );
					return newPig3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					var newPig4Tile:Pig4Tile = new Pig4Tile();
					newPig4Tile.gotoAndPlay( int(Math.random()*100) );
					return newPig4Tile;
				}
			} else if(tileData.getBuildingId() == BUILDING_COW_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					var newCow1Tile:Cow1Tile = new Cow1Tile();
					newCow1Tile.gotoAndPlay( int(Math.random()*100) );
					return newCow1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					var newCow2Tile:Cow2Tile = new Cow2Tile();
					newCow2Tile.gotoAndPlay( int(Math.random()*100) );
					return newCow2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					var newCow3Tile:Cow3Tile = new Cow3Tile();
					newCow3Tile.gotoAndPlay( int(Math.random()*100) );
					return newCow3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					var newCow4Tile:Cow4Tile = new Cow4Tile();
					newCow4Tile.gotoAndPlay( int(Math.random()*100) );
					return newCow4Tile;
				}
			} else if(tileData.getBuildingId() == BUILDING_SHEEP_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					var newSheep1Tile:Sheep1Tile = new Sheep1Tile();
					newSheep1Tile.gotoAndPlay( int(Math.random()*100) );
					return newSheep1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					var newSheep2Tile:Sheep2Tile = new Sheep2Tile();
					newSheep2Tile.gotoAndPlay( int(Math.random()*100) );
					return newSheep2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					var newSheep3Tile:Sheep3Tile = new Sheep3Tile();
					newSheep3Tile.gotoAndPlay( int(Math.random()*100) );
					return newSheep3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					var newSheep4Tile:Sheep4Tile = new Sheep4Tile();
					newSheep4Tile.gotoAndPlay( int(Math.random()*100) );
					return newSheep4Tile;
				}
			} else if(tileData.getBuildingId() == BUILDING_OSTRICH_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					var newOstrich1Tile:Ostrich1Tile = new Ostrich1Tile();
					newOstrich1Tile.gotoAndPlay( int(Math.random()*100) );
					return newOstrich1Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					var newOstrich2Tile:Ostrich2Tile = new Ostrich2Tile();
					newOstrich2Tile.gotoAndPlay( int(Math.random()*100) );
					return newOstrich2Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					var newOstrich3Tile:Ostrich3Tile = new Ostrich3Tile();
					newOstrich3Tile.gotoAndPlay( int(Math.random()*100) );
					return newOstrich3Tile;
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					var newOstrich4Tile:Ostrich4Tile = new Ostrich4Tile();
					newOstrich4Tile.gotoAndPlay( int(Math.random()*100) );
					return newOstrich4Tile;
				}
			} else if(tileData.getBuildingId() == BUILDING_FISH_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Fish1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Fish2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Fish3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Fish4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_SQUID_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Squid1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Squid2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Squid3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Squid4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_SCALLOPS_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Scallops1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Scallops2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Scallops3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Scallops4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_SHRIMP_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Shrimp1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Shrimp2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Shrimp3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Shrimp4Tile();
				}
			} else if(tileData.getBuildingId() == BUILDING_OYSTER_ID){
				if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS1){
					return new Oyster1Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_PROCESS2){
					return new Oyster2Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_COMPLETED){
					return new Oyster3Tile();
				}else if(tileData.getBuildingStatus() == Tile.BUILDING_ROTTED){
					return new Oyster4Tile()
				}
			} else {
				var tile:AbstractFarmTile = new EmptyFarmTile();	
				tile.graphics.beginFill(0x00FF00, 0.7);
				tile.graphics.drawRect(0,0, 20,20);
				tile.graphics.endFill();
				return tile;
			}
			
			return null;
		}
	}
	
}
