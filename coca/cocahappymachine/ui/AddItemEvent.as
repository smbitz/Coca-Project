package cocahappymachine.ui {
	import flash.events.Event;
	import cocahappymachine.data.Tile;
	
	public class AddItemEvent extends Event {

		private var clickedTile:Tile;
		
		public function AddItemEvent(type:String) {
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
