package cocahappymachine.util {
	import flash.display.Stage;
	
	public interface DragConstrain {
		
		function getMinX(s:Stage):Number;
		function getMinY(s:Stage):Number;
		function getMaxX(s:Stage):Number;
		function getMaxY(s:Stage):Number;
	}
	
}
