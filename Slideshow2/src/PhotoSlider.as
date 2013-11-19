package  
{
	import a24.tween.Ease24;
	import a24.tween.EventTween24;
	import a24.tween.Tween24;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class PhotoSlider extends Sprite 
	{
		private var _bitmapList:Array/*Bitmap*/ = [];
		private var _count:int = 0;
		public var position:Point = new Point(0, 0);
		public function PhotoSlider() 
		{
			init();
		}
		
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
		}
		public function addBitmapData(bitmapData:BitmapData, rectangle:Rectangle):void 
		{
			var bitmap:Bitmap = new Bitmap(new BitmapData(rectangle.width, rectangle.height, false));
			bitmap.bitmapData.copyPixels(bitmapData, rectangle, new Point());
			_bitmapList.push(bitmap);
		}
		
		public function setMask():void {
			var maskShape:Shape = new Shape();
			maskShape.graphics.beginFill(0xFF0000);
			maskShape.graphics.drawRect(0, 0, _bitmapList[0].width, _bitmapList[0].height);
			maskShape.graphics.endFill();
			addChild(maskShape);
			mask = maskShape;
		}
		
		public function doTween(delayMS:int = 0, isVartical:Boolean = false):void 
		{
			_count ++;
			_count %= _bitmapList.length;
			var target:Bitmap = _bitmapList[_count];
			if (isVartical) {
				target.x = target.width * -1;
			}else {
				target.y = target.height * -1;
			}
			addChild(target);
			Tween24.tween(target, 0.35, Ease24._1_SineOut).xy(0, 0).delay(delayMS / 1000).play();
		}
	}
	
}