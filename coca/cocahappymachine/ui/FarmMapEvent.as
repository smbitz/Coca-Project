package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.Tile;
	
	public class FarmMapEvent extends Event {
		
		public static const TILE_PURCHASE:String = "TILE_PURCHASE";
		public static const TILE_BUILD:String = "TILE_BUILD";
		public static const TILE_ADDITEM:String = "TILE_ADDITEM";
		public static const TILE_HARVEST:String = "TILE_HARVEST";
		public static const MOVE_DESTINATION:String = "MOVE_DESTINATION";
		public static const TILE_SHOTCUTSUPPLY:String = "TILE_SHOTCUTSUPPLY";
		
		private var clickedTile:AbstractFarmTile;
		
		public function FarmMapEvent(type:String) {
			super(type);
		}

		public function setClickedTile(t:AbstractFarmTile){
			clickedTile = t;
		}
		
		public function getClickedTile():AbstractFarmTile{
			return clickedTile;
		}
	}
	
}
