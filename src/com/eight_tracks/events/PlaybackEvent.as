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

package com.eight_tracks.events 
{
	import flash.events.Event;

	/**
	 * Events related to playback of media files.
	 * 
	 * @author Stephan Florquin
	 */
	public class PlaybackEvent extends Event
	{
		
		//---------------------------------------------------------------------
		// Class constants
		//---------------------------------------------------------------------

		/**
		 * Reached end of media file.
		 */
		public static const PLAYBACK_COMPLETE:String = "playbackComplete";
		
		/**
		 * Started/resumed playback of media file.
		 */
		public static const PLAYBACK_STARTED:String = "playbackStarted";
		
		/**
		 * Paused media file.
		 */
		public static const PLAYBACK_PAUSED:String = "playbackPaused";
		
		/**
		 * Playhead position was updated.
		 */
		public static const PLAYBACK_UPDATED:String = "playbackUpdated";
		
		//---------------------------------------------------------------------
		// Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function PlaybackEvent(type:String, bubbles:Boolean = false,
				cancelable:Boolean = false, position:int = 0, length:int = 0)
		{
			super(type, bubbles, cancelable);
			
			_position = position;
			_length = length;
		}
		
		//---------------------------------------------------------------------
		// Variables
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _position:int;
		
		/**
		 * @private
		 */
		private var _length:int;
		
		//---------------------------------------------------------------------
		// Overridden properties
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public override function clone():Event
		{
			return new PlaybackEvent(type, bubbles, cancelable, _position,
					_length);
		}
		
		//---------------------------------------------------------------------
		// GETTERS & SETTERS
		//---------------------------------------------------------------------
		
		/**
		 * Playhead position, in milliseconds.
		 */
		public function get position():* { return _position; }
		
		public function set position(value:*):void 
		{
			_position = value;
		}
		
		/**
		 * Track length, in milliseconds.
		 */
		public function get length():* { return _length; }
		
		public function set length(value:*):void 
		{
			_length = value;
		}
		
	}
	
}
