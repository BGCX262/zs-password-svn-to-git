package com
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import mx.collections.ArrayCollection;

	public class DataGridProvider
	{
		public function DataGridProvider()
		{
		}
		public static function distillBytes(source:IDataInput , arr:ArrayCollection):ArrayCollection
		{
			arr.removeAll();
			var len:int = source.readInt();
			for(var i:int = 0 ;i< len; i++)
			{
				var itemVo:ItemVO = new ItemVO();
				itemVo.key = ByteString.readString(source);
				itemVo.value = ByteString.readString(source);
				arr.addItem(itemVo);
			}
			return arr;
		}
		
		public static function pushBytes(arr:ArrayCollection , dest:IDataOutput):void
		{
			dest.writeInt(arr.length);
			for each(var i:ItemVO in arr)
			{
				ByteString.writeString(i.key , dest);
				ByteString.writeString(i.value , dest);
			}
		}
		
		public static function writeBmd(arr:ArrayCollection):BitmapData
		{
			var pt:Point = getWH(arr);
			var bmd:BitmapData = new BitmapData(pt.x, pt.y, false,0xffffff);
			for(var i:int = 0; i<pt.y; i+=2)
			{
				var value:ItemVO = arr.getItemAt(i/2) as ItemVO;
				ByteString.writeBmd(value.key,bmd,i);
				ByteString.writeBmd(value.value, bmd,i+1);
			}
			return bmd;
		}
		
		public static function readBmd(source:BitmapData ,arr:ArrayCollection):void
		{
			var h:int = source.height/2;
			arr.removeAll();
			for(var i:int = 0; i< source.height ;i+=2)
			{
				var itemVo:ItemVO = new ItemVO();
				itemVo.key = ByteString.readBmd(source,i);
				itemVo.value = ByteString.readBmd(source , i+1);
				arr.addItem(itemVo);				
			}
		}
		
		private static function getWH(data:ArrayCollection):Point
		{
			var pt:Point = new Point();
			pt.y = data.length * 2;
			var len:int = 0;
			for(var i:int = 0 ; i< data.length ; i++)
			{
				var item:ItemVO = data.getItemAt(i) as ItemVO;
				if(len < item.key.length)
					len = item.key.length;
				if(len < item.value.length)
					len = item.value.length;
			}
			pt.x = len + 1;//留出一个存字符长
			return pt;
		}
	}
}