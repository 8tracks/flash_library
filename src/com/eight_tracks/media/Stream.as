package com.eight_tracks.media 
{
	import com.eight_tracks.events.PlaybackEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	/**
	 * A 'stream audio file' (for instance AAC).
	 * 
	 * @author Stephan Florquin
	 */
	public class Stream extends AbstractAudioFile
	{
		
		//---------------------------------------------------------------------
		// Members
		//---------------------------------------------------------------------
		
		private var _netStream:NetStream;
		private var _ready:Boolean;
		private var _timer:Timer = new Timer(100);
		
		//---------------------------------------------------------------------
		// Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param	url	the URL of the sound file
		 */
		public function Stream(url:String) 
		{
			super(url);
			
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			load();
		}
		
		//---------------------------------------------------------------------
		// Overrides
		//---------------------------------------------------------------------
		
		public override function set volume(value:Number):void
		{
			var soundTransform:SoundTransform = new SoundTransform(value);
			_netStream.soundTransform = soundTransform;
			
			super.volume = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function play():void
		{
			if (_ready)
			{
				_netStream.resume();
			}
			else
			{
				_netStream.play(_url);
				
				_ready = true;
			}
			
			_timer.start();
			
			super.play();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function pause():void
		{
			_netStream.pause();
			
			_timer.stop();
			
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
			var netConnection:NetConnection = new NetConnection();
			
			netConnection.connect(null);
			
			_netStream = new NetStream(netConnection);
			_netStream.client = this;
			_netStream.bufferTime = 3;
			
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		}
		
		/**
		 * @private
		 */
		private function netStatusHandler(event:NetStatusEvent):void
		{
			trace(event.info.code);
			
			switch(event.info.code)
			{				
				case "NetStream.Play.Stop":
				dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_COMPLETE));
				break;
				
				default:
				trace(event.info.code);
			}
		}
		
		/**
		 * @private
		 */
		public function onMetaData(info:Object):void
		{
			_length = info.duration;
		}
		
		/**
		 * @private
		 */
		private function timerHandler(e:TimerEvent):void 
		{
			_position = _netStream.time;
			dispatchEvent(new PlaybackEvent(PlaybackEvent.PLAYBACK_UPDATED, false, false, _position, _length));
		}
		
	}
	
}