package com
{
	import flash.display.BitmapData;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class ByteString
	{
		public function ByteString()
		{
			
		}
		public static function writeString(str:String,dest:IDataOutput):void
		{
			dest.writeInt(str.length);
			for(var i:int=0; i< str.length ;i++)
			{
				var value:int = str.charCodeAt(i) + 100;
				dest.writeUnsignedInt(value);
			}
		}
		
		public static function readString(source:IDataInput):String
		{
			var str:String = '';
			var len:int = source.readInt();
			for(var i:int = 0; i< len ; i++)
			{
				var value:uint = source.readUnsignedInt();
				value -= 100;
				str += String.fromCharCode(value);
			}
			return str;
		}
		
		public static function writeBmd(str:String, dest:BitmapData, yy:int):void
		{
			dest.setPixel(0,yy,str.length);
			for(var i:int = 0; i<str.length ; i++)
			{
				var value:uint = str.charCodeAt(i) + 100;
				dest.setPixel(i+1 , yy , value);
			}
		}
		
		public static function readBmd(source:BitmapData, yy:int):String
		{
			var len:int = source.getPixel(0,yy);
			var str:String = '';
			for(var i:int = 0 ; i<len ; i++)
			{
				var value:uint = source.getPixel(i+1 ,yy) - 100;
				str += String.fromCharCode(value);
			}
			return str;
		}
		
	}
}