package com.commands
{
	import com.DataGridProvider;
	import com.Debug;
	import com.ItemVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;

	public class SaveFileCommand implements ICommand
	{
		private var _file:File;
		
		private var _data:ArrayCollection;
		public function SaveFileCommand(da:ArrayCollection , f:File )
		{
			_data = da;
			_file = f;
		}
		
		public function excute():void
		{
			var fs:FileStream = new FileStream();
			fs.open(_file,FileMode.WRITE);
			fs.position = 0;
			//DataGridProvider.pushBytes(_data , fs);
			fs.writeBytes(outputBytes());
			fs.close();
			//_file.save(outputBytes(),'fuck.jpg');
			//_file.save(outputBytes());
		}
		
		private function outputBytes():ByteArray
		{
			var jp:PNGEncoder = new PNGEncoder()
			var bmd:BitmapData = DataGridProvider.writeBmd(_data);
			Debug.bitmap(bmd);
			return jp.encode(bmd);
		}
	}
}