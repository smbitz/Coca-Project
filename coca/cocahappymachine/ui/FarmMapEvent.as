package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.Tile;
	
	public class FarmMapEvent extends Event {
		
		public static const TILE_CLICK:String = "TILE_CLICK";
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
