package cocahappymachine.util {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DragManager {

		private static var instance:DragManager;
		private var stage:Stage;
		private var isDrag:Boolean;
		private var dragObject:Array;		//array of DragableObject
		private var draggingObject:MovieClip;
		private var pointX:Number;
		private var pointY:Number;
		
		public function DragManager() {
			dragObject = new Array();
			isDrag = false;
			if(instance != null){
				throw new Error("Singletone Pattern Implemented, new operation is forbidden");
			}
		}
		
		public static function getInstance():DragManager{
			if(instance == null){
				instance = new DragManager();
			}
			return instance;
		}

		public function setStage(s:Stage){
			stage = s;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function onMouseUp(event:MouseEvent){
			isDrag = false;
		}
		
		public function addObject(obj:MovieClip){
			if(stage == null){
				throw new Error("For using DragManager please set Stage at the beginning of application");
			}
			dragObject.push(obj);
			obj.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			obj.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function removeObject(obj:MovieClip){
			dragObject.splice(dragObject.indexOf(obj), 1);
		}
		
		public function onMouseDown(event:MouseEvent){
			isDrag = true;
			draggingObject = MovieClip(event.currentTarget);
			pointX = event.stageX;
			pointY = event.stageY;
		}
		
		public function onEnterFrame(event:Event){
			if(isDrag){
				var moveX:Number = (stage.mouseX - pointX) / 3;
				var moveY:Number = (stage.mouseY - pointY) / 3;
				draggingObject.x += moveX;
				draggingObject.y += moveY;
				pointX += moveX;
				pointY += moveY;
			}
		}
	}
}