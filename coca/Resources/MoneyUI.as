package Resources {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class MoneyUI extends MovieClip {
		
		public var moneyField:TextField;
		
		public function MoneyUI() {
			// constructor code
		}
		
		public function setMoney(m:int){
			moneyField.text = m.toString();
		}
	}
}