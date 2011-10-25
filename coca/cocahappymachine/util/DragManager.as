package cocahappymachine.util {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class DragManager {

		private static const DRAG_CHECK_INTERVAL:Number = 200;
		
		private static var instance:DragManager;
		
		private var stage:Stage;
		private var isDrag:Boolean;
		private var dragObject:Array;		//array of DragableObject
		private var draggingObject:MovieClip;
		private var pointX:Number;
		private var pointY:Number;
		private var dragCheckX:Number;
		private var dragCheckY:Number;
		private var dragCheckTimer:Timer;
		
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
			if(draggingObject){
				draggingObject.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		public function addObject(obj:MovieClip){
			if(stage == null){
				throw new Error("For using DragManager please set Stage at the beginning of application");
			}
			dragObject.push(obj);
			obj.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function removeObject(obj:MovieClip){
			dragObject.splice(dragObject.indexOf(obj), 1);
		}
		
		public function onMouseDown(event:MouseEvent){
			draggingObject = MovieClip(event.currentTarget);
			pointX = event.stageX;
			pointY = event.stageY;
			dragCheckX = event.stageX;
			dragCheckY = event.stageY;
			draggingObject.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			isDrag = false;
		}
		
		public function onEnterFrame(event:Event){
			var moveX:Number = (stage.mouseX - pointX) / 3;
			var moveY:Number = (stage.mouseY - pointY) / 3;
			draggingObject.x += moveX;
			draggingObject.y += moveY;
			pointX += moveX;
			pointY += moveY;
			if((Math.abs(dragCheckX - stage.mouseX) > 20) || (Math.abs(dragCheckY - stage.mouseY) > 20)){
				isDrag = true;
			}
		}
		
		public function isDragging():Boolean{
			return isDrag;
		}
	}
}