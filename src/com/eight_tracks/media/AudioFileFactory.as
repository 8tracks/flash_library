/*

Copyright (C) 2011 by 8tracks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

package com.eight_tracks.media 
{
	
	/**
	 * Audio file factory with MP3 and AAC support (based on file extenstion).
	 * 
	 * @author Stephan Florquin
	 */
	public class AudioFileFactory 
	{
		
		//---------------------------------------------------------------------
		// MEMBERS
		//---------------------------------------------------------------------
		
		private static var _builders:Object = new Object();
		private static var _defaultBuilder:IAudioFileBuilder;
		
		//---------------------------------------------------------------------
		// CONSTRUCTOR
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */		
		public function AudioFileFactory() 
		{
			setDefaultBuilder(new SoundFileBuilder());
			addBuilder('mp4', new StreamBuilder());
			addBuilder('m4a', new StreamBuilder());
		}
		
		//---------------------------------------------------------------------
		// METHODS
		//---------------------------------------------------------------------
		
		/**
		 * Attach an audio file builder to an extension.
		 * 
		 * @param	fileExt	the file extension
		 * @param	builder	the audio file builder
		 */
		public function addBuilder(fileExt:String, 
				builder:IAudioFileBuilder):void
		{
			_builders[fileExt.toLowerCase()] = builder;
		}
		
		/**
		 * Sets the default audio file builder for all others file extensions.
		 * 
		 * @param	builder	the audio file builder
		 */
		public function setDefaultBuilder(builder:IAudioFileBuilder):void
		{
			_defaultBuilder = builder;	
		}
		
		/**
		 * Loads an audio file from a URL
		 * 
		 * @param	url	the URL of the audio file
		 * @return	an interface for the audio file
		 */
		public function create(url:String):IAudioFile
		{
			var parts:Array = url.split('.');
			var fileExt:String = parts.pop().toLowerCase();
			
			if (_builders[fileExt])
			{
				return _builders[fileExt].build(url);
			}
			
			return _defaultBuilder.build(url);
		}
		
	}
	
}