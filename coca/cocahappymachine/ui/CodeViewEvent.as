package cocahappymachine.ui {
	import flash.events.Event;
	
	public class CodeViewEvent extends Event {

		private var itemId:String;
		private var code:String;
		
		public function CodeViewEvent(type:String) {
			super(type);
		}

		public function setItemId(id:String){
			itemId = id
		}
		
		public function setCode(c:String){
			code = c;
		}
		
		public function getItemId():String{
			return itemId;
		}
		
		public function getCode():String{
			return code;
		}
	}
	
}
