package cocahappymachine.ui {
	import flash.events.Event;
	
	public class CodeViewEvent extends Event {

		private var itemId:String;
		private var code:String;
		private var expireDate:String;
		
		public function CodeViewEvent(type:String) {
			super(type);
		}

		public function setItemId(id:String){
			itemId = id
		}
		
		public function setCode(c:String){
			code = c;
		}
		
		public function setExpireDate(e:String){
			expireDate = e;
		}
		
		public function getItemId():String{
			return itemId;
		}
		
		public function getCode():String{
			return code;
		}
		
		public function getExpireDate():String{
			return expireDate;
		}
	}
	
}
