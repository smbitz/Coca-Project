package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.Tile;
	
	public class TileUpdateEvent extends Event {

		public static const TILE_UPDATE:String = "TILE_UPDATE";
		
		private var tile:Tile;
		
		public function TileUpdateEvent(type:String) {
			super(type);
		}
		
		public function setTile(t:Tile){
			tile = t;
		}
		
		public function getTile():Tile{
			return tile;
		}

	}
	
}
