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
	import flash.events.IEventDispatcher;
	
	/**
	 * The interface for all audio files.
	 * 
	 * @author Stephan Florquin
	 */
	public interface IAudioFile extends IEventDispatcher
	{
		/**
		 * Play/resume the audio file.
		 */
		function play():void;
		
		/**
		 * Pause the audio file.
		 */
		function pause():void;
		
		/**
		 * Volume [0.0 - 1.0].
		 */
		function get volume():Number;
		function set volume(value:Number):void;
		
		/**
		 * Playhead position.
		 */
		function get position():Number;
		
		/**
		 * Track length.
		 */
		function get length():Number;
	}
	
}