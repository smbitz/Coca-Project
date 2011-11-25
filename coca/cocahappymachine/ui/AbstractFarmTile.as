package cocahappymachine.ui {
	import flash.display.MovieClip;
	import cocahappymachine.data.Tile;
	import Resources.FarmTileHitArea;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import Resources.SupplyBubble;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class AbstractFarmTile extends MovieClip {

		private var tileData:Tile;
		
		private var hitMC:MovieClip;
		protected var glowFilter:GlowFilter;
		protected var bubble:SupplyBubble;
		protected var addTile:MovieClip;
		protected var animate:MovieClip;
		
		public function AbstractFarmTile(t:AbstractFarmTile=null) {
			if(t != null){
				tileData = t.getData()
			}
			glowFilter = new GlowFilter(0xFFFFFF, 0.8, 8, 8, 5);
			hitMC = new FarmTileHitArea();
			this.hitArea = hitMC;
			hitMC.mouseEnabled = true;
			this.mouseChildren = false;
			hitMC.alpha = 0;
			this.addChild(hitMC);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			bubble = new SupplyBubble();
			bubble.visible = false;
			bubble.x = this.width / 2;
			bubble.y = this.height / 3;
			this.addChild(bubble);
			addTile = new MovieClip();
			addTile.visible = true;
			addTile.x = this.width / 2;
			addTile.y - this.height / 3;
			this.addChild(addTile);
			animate = new MovieClip();
			animate.visible = true;
			animate.x = this.width / 2;
			animate.y = this.height / 3;
			this.addChild(animate);
		}

		public function setData(t:Tile){
			tileData = t;
		}
		
		public function setBubble(mc:DisplayObject){
			if(mc == null){
				bubble.visible = false;
			} else {
				bubble.visible = true;
				bubble.setItemMC(mc);
			}
		}
		
		public function setAddTile(mc:MovieClip){
			while(addTile.numChildren != 0){
				addTile.removeChildAt(0);
			}
			addTile.addChild(mc);
			mc.play();
		}
		
		public function setAnimate(mc:MovieClip){
			if(tileData.getBuilding() == null){
				return;
			}
			while(animate.numChildren != 0){
				animate.removeChildAt(0);
			}
			mc.addEventListener(Event.ENTER_FRAME, onAnimateFrame);
			animate.addChild(mc);
			var t:Timer;
			if(tileData.getExtraId() == "NULL" ){
				t = new Timer(5000 + Math.random() * 60000, 0);				
			} else {
				t = new Timer(2000, 0);
			}
			t.addEventListener(TimerEvent.TIMER, onAnimateRun);
			t.start();
		}
		
		public function onAnimateFrame(event:Event){
			var mc:MovieClip = MovieClip(animate.getChildAt(0));
			if(mc.totalFrames == mc.currentFrame){
				mc.stop();
			}
		}
		
		public function onAnimateRun(event:TimerEvent){
			var mc:MovieClip = MovieClip(animate.getChildAt(0));
			mc.gotoAndPlay(0);
		}
		
		public function getData():Tile{
			return tileData;
		}
		
		public function onMouseOut(event:MouseEvent){
			this.filters = null;
		}
		
		public function onMouseOver(event:MouseEvent){
			this.filters = [glowFilter];
		}
	}
	
}