package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.Tile;
	
	public class FarmMapEvent extends Event {
		
		public static const TILE_PURCHASE:String = "TILE_PURCHASE";
		public static const TILE_BUILD:String = "TILE_BUILD";
		public static const TILE_ADDITEM:String = "TILE_ADDITEM";
		public static const TILE_HARVEST:String = "TILE_HARVEST";
		
		private var clickedTile:Tile;
		
		public function FarmMapEvent(type:String) {
			super(type);
		}

		public function setClickedTile(t:Tile){
			clickedTile = t;
		}
		
		public function getClickedTile():Tile{
			return clickedTile;
		}
	}
	
}
