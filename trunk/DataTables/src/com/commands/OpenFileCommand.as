package com.commands
{
	import com.DataGridProvider;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.graphics.codec.JPEGEncoder;

	public class OpenFileCommand implements ICommand
	{
		private var _file:File;
		private var _data:ArrayCollection;
		public function OpenFileCommand(da:ArrayCollection, f:File)
		{
			_data = da;
			_file = f;
		}
		
		public function excute():void
		{
/*			var fs:FileStream = new FileStream();
			fs.open(_file, FileMode.READ);
			fs.position = 0;
			DataGridProvider.distillBytes(fs,_data);
			fs.close();
*/			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			loader.load(new URLRequest(_file.nativePath));
		}
		
		private function onLoaded(e:Event):void
		{
			var loader:LoaderInfo = e.target as LoaderInfo;
			var bmd:BitmapData = new BitmapData(loader.content.width , loader.content.height , false,0x0);
			bmd.draw(loader.content);
			DataGridProvider.readBmd(bmd,_data);
		}
	}
}