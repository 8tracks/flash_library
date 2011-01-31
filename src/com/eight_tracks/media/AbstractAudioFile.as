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
	import com.eight_tracks.events.PlaybackEvent;
	import com.eight_tracks.events.PropertyChangeEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * Abstract class for all audio files.
	 * 
	 * @author Stephan Florquin
	 */
	public class AbstractAudioFile extends EventDispatcher
			implements IAudioFile
	{
		
		//---------------------------------------------------------------------
		// MEMBERS
		//---------------------------------------------------------------------
		
		protected var _url:String;
		protected var _volume:Number = .75;
		protected var _position:Number = 0;
		protected var _length:Number;
		
		//---------------------------------------------------------------------
		// CONSTRUCTOR
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */		
		public function AbstractAudioFile(url:String) 
		{
			_url = url;
		}
		
		//---------------------------------------------------------------------
		// METHODS
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function play():void
		{
			dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_STARTED));
		}
		
		/**
		 * @inheritDoc
		 */
		public function pause():void
		{
			dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_PAUSED));
		}
		
		//---------------------------------------------------------------------
		// GETTERS & SETTERS
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			if (value != _volume)
			{
				var old:Number = _volume;
				
				_volume = value;
				
				dispatchEvent(new PropertyChangeEvent(
						PropertyChangeEvent.PROPERTY_UPDATED, false, false, 
							'volume', old, value));
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get position():Number { return _position; }
		
		/**
		 * @inheritDoc
		 */
		public function get length():Number { return _length; }
		
	}
	
}