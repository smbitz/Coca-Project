package  cocahappymachine.ui {
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import Resources.CharacterBoyBack2;
	import Resources.CharacterBoyBack1;
	import Resources.CharacterBoyBack3;
	import Resources.CharacterBoyBack4;
	import Resources.CharacterBoyFront2;
	import Resources.CharacterBoyFront1;
	import Resources.CharacterBoyFront3;
	import Resources.CharacterBoyFront4;
	import Resources.CharacterGirlBack2;
	import Resources.CharacterGirlBack1;
	import Resources.CharacterGirlBack3;
	import Resources.CharacterGirlBack4;
	import Resources.CharacterGirlFront2;
	import Resources.CharacterGirlFront1;
	import Resources.CharacterGirlFront3;
	import Resources.CharacterGirlFront4;
	import flashx.textLayout.formats.Float;
	import com.greensock.easing.Linear;
	
	public class Character extends MovieClip {
	
		private static const WALK_SPEED:Number = 40; //pixel per sec
		public static const SEX_MALE:int = 1;
		public static const SEX_FEMALE:int = 2;
		
		private var sex:int;
		private var walkBack:MovieClip;
		private var standBack:MovieClip;
		private var waterBack:MovieClip;
		private var plantBack:MovieClip;
		private var walkFront:MovieClip;
		private var standFront:MovieClip;
		private var waterFront:MovieClip;
		private var plantFront:MovieClip;
		
		public function Character( sex:int ) {
			this.sex = sex;
			if(sex == SEX_MALE){
				walkBack = new CharacterBoyBack2();
				standBack = new CharacterBoyBack1();
				waterBack = new CharacterBoyBack3();
				plantBack = new CharacterBoyBack4();
				walkFront = new CharacterBoyFront2();
				standFront = new CharacterBoyFront1();
				waterFront = new CharacterBoyFront3();
				plantFront = new CharacterBoyFront4();
			} else {
				walkBack = new CharacterGirlBack2();
				standBack = new CharacterGirlBack1();
				waterBack = new CharacterGirlBack3();
				plantBack = new CharacterGirlBack4();
				walkFront = new CharacterGirlFront2();
				standFront = new CharacterGirlFront1();
				waterFront = new CharacterGirlFront3();
				plantFront = new CharacterGirlFront4();
			}
			this.addChild(standFront);
			stand();
		}

		public function randomWalk(){
			this.removeChildAt(0);
			var targetX:Number = Math.random() * (FarmMap.CHARACTER_MAX_X - FarmMap.CHARACTER_MIN_X) + FarmMap.CHARACTER_MIN_X;
			var targetY:Number = Math.random() * (FarmMap.CHARACTER_MAX_Y - FarmMap.CHARACTER_MIN_Y) + FarmMap.CHARACTER_MIN_Y;
			var distance:Number = Math.pow(Math.pow(x-targetX,2) + Math.pow(y-targetY,2), 0.5);
			if(this.x > targetX){
				this.scaleX = 1;
			} else {
				this.scaleX = -1;
			}
			if(this.y > targetY){
				this.addChild(walkBack);
				this.scaleX *= -1;
			} else {
				this.addChild(walkFront);
			}
			TweenLite.to(this, distance / WALK_SPEED, {x:targetX, y:targetY, onComplete:onWalkComplete, ease:Linear.easeNone});
			function onWalkComplete(){
				stand();
			}
		}
		
		public function stand(){
			this.removeChildAt(0);
			this.addChild(standFront);
			TweenLite.to(this, Math.random()*20, {delay:1, onComplete:onStandComplete});
			function onStandComplete(){
				randomWalk();
			}
		}
	}
}