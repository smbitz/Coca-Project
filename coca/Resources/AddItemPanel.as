package Resources {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import cocahappymachine.ui.AddItemEvent;
	import cocahappymachine.data.Tile;
	
	public class AddItemPanel extends MovieClip {

		public static const DIALOG_CLOSE:String = "DIALOG_CLOSE";
		public static const SUPPLYITEM_CLICK:String = "SUPPLYITEM_CLICK";
		public static const EXTRAITEM1_CLICK:String = "EXTRAITEM1_CLICK";
		public static const EXTRAITEM2_CLICK:String = "EXTRAITEM2_CLICK";
		public static const MOVE_CLICK:String = "MOVE_CLICK";

		public var closeButton:MovieClip;
		public var supplyItemButton:SupplyItemButton;
		public var extraItem1Button:ExtraItemButton;
		public var extraItem2Button:ExtraItemButton;
		public var moveButton:MoveButton;
		
		private var tile:Tile;
		
		public function AddItemPanel() {
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			supplyItemButton.addEventListener(MouseEvent.CLICK, onSupplyItemClick);
			extraItem1Button.addEventListener(MouseEvent.CLICK, onExtraItem1Click);
			extraItem2Button.addEventListener(MouseEvent.CLICK, onExtraItem2Click);
			moveButton.addEventListener(MouseEvent.CLICK, onMoveClick);
		}
		
		public function setTile(t:Tile){
			tile = t;
		}
		
		public function onCloseButtonClick(event:MouseEvent){
			this.dispatchEvent(new Event(DIALOG_CLOSE));
		}
		
		public function onSupplyItemClick(event:MouseEvent){
			var e:AddItemEvent = new AddItemEvent(SUPPLYITEM_CLICK);
			e.setClickedTile(tile);
			this.dispatchEvent(e);
		}
		
		public function onExtraItem1Click(event:MouseEvent){
			var e:AddItemEvent = new AddItemEvent(EXTRAITEM1_CLICK);
			e.setClickedTile(tile);
			this.dispatchEvent(e);
		}
		
		public function onExtraItem2Click(event:MouseEvent){
			var e:AddItemEvent = new AddItemEvent(EXTRAITEM2_CLICK);
			e.setClickedTile(tile);
			this.dispatchEvent(e);
		}
		
		public function onMoveClick(event:MouseEvent){
			var e:AddItemEvent = new AddItemEvent(MOVE_CLICK);
			e.setClickedTile(tile);
			this.dispatchEvent(e);
		}
	}
}
