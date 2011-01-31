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
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 * A 'sound file' (for instance MP3).
	 * 
	 * @author Stephan Florquin
	 */
	public class SoundFile extends AbstractAudioFile implements IAudioFile
	{
		//---------------------------------------------------------------------
		// Members
		//---------------------------------------------------------------------
		
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var _ready:Boolean;
		private var _playing:Boolean;
		private var _timer:Timer = new Timer(100);
		
		//---------------------------------------------------------------------
		// Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param	url	the URL of the sound file
		 */
		public function SoundFile(url:String) 
		{
			super(url);
			
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			load();
		}
		
		//---------------------------------------------------------------------
		// Overrides
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public override function set volume(value:Number):void
		{
			if (_soundChannel)
			{
				var soundTransform:SoundTransform = new SoundTransform(value);
				_soundChannel.soundTransform = soundTransform;
			}
			
			super.volume = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function play():void
		{
			if (_ready)
			{
				_soundChannel = _sound.play(_position);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_timer.start();
				var soundTransform:SoundTransform = new SoundTransform(_volume);
				_soundChannel.soundTransform = soundTransform;
				super.play();
			}
			
			_playing = true;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function pause():void
		{
			if (_ready)
			{
				_timer.stop();
				_soundChannel.stop();
			}
			
			_playing = false;
			
			super.pause();
		}
		
		//---------------------------------------------------------------------
		// Methods
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function load():void
		{
			_sound = new Sound(new URLRequest(_url));
			_sound.addEventListener(Event.OPEN, openHandler);
		}
		
		/**
		 * @private
		 */
		private function openHandler(event:Event):void
		{
			_ready = true;
			
			if (_playing)
			{
				play();
			}
		}
		
		/**
		 * @private
		 */
		private function soundCompleteHandler(event:Event):void
		{
			dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_COMPLETE));
		}
		
		/**
		 * @private
		 */
		private function timerHandler(e:TimerEvent):void 
		{
			_length = Math.ceil(_sound.length / (_sound.bytesLoaded / 
					_sound.bytesTotal));
			_position = _soundChannel.position;
			
			dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_UPDATED,
					false, false, _position, _length));
		}
		
	}
	
}