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
	* Property change events.
	* 
	* @author Stephan Florquin
	*/
	public class PropertyChangeEvent extends Event
	{
		
		//---------------------------------------------------------------------
		// CONSTANTS
		//---------------------------------------------------------------------
		
		/**
		 * A property was added.
		 */
		public static const PROPERTY_ADDED:String = "propertyAdded";
		
		/**
		 * A property was updated.
		 */
		public static const PROPERTY_UPDATED:String = "propertyUpdated";
		
		/**
		 * A property was removed.
		 */
		public static const PROPERTY_REMOVED:String = "propertyRemoved";
		
		//---------------------------------------------------------------------
		// MEMBERS
		//---------------------------------------------------------------------
		
		private var _property:*;
		private var _oldValue:*;
		private var _newValue:*;
		
		//---------------------------------------------------------------------
		// CONSTRUCTOR
		//---------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */		
		public function PropertyChangeEvent(type:String, 
				bubbles:Boolean = false, cancelable:Boolean = false, 
				property:* = null, oldValue:* = null, newValue:* = null) 
		{
			super(type, bubbles, cancelable);
			
			_property = property;
			_oldValue = oldValue;
			_newValue = newValue;
		}
		
		//---------------------------------------------------------------------
		// OVERRIDES
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public override function clone():Event
		{
			return new PropertyChangeEvent(type, bubbles, cancelable, _property, _oldValue, _newValue);
		}
		
		//---------------------------------------------------------------------
		// GETTERS & SETTERS
		//---------------------------------------------------------------------
		
		/**
		 * Name of the property.
		 */
		public function get property():* { return _property; }
		
		public function set property(value:*):void 
		{
			_property = value;
		}
		
		/**
		 * Old property value.
		 */
		public function get oldValue():* { return _oldValue; }
		
		public function set oldValue(value:*):void 
		{
			_oldValue = value;
		}
		
		/**
		 * New property value.
		 */
		public function get newValue():* { return _newValue; }
		
		public function set newValue(value:*):void 
		{
			_newValue = value;
		}
		
	}
	
}