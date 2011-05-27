package org.ghostfish.collections.immutable
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * This is a typed version of the HashMap class that implements
	 * pseudo generics by statically typing the values.
	 * <p>
	 * Unfortunately the keys
	 * can't be typed as this class is built upon Proxy, which casts all
	 * keys to QNames.
	 * </p><p>
	 * See the HashMap class for more details.</p> 
	 */
	public dynamic class TypedHashMap extends HashMap
	{
		protected var _valueType:Class;

		/**
		 * Creates a new (empty) typed hashmap.
		 *  
		 * @param valueType	The type of the values for this hashmap.
		 * 
		 */
		function TypedHashMap(valueType:Class)
		{
			super();
			_valueType = valueType;
			
			if (valueType == null)
			{
				throw new Error("TypedHashMap requires a value type be specified in the constructor");
			}
		}

		/**
		 * @private
		 * 
		 * Sets a new key/ value pair via the map[key] = value notation.
		 * <p>
		 * Expands upon the base class' method by checking the types of the key and value.
		 * 
		 * @param key	The key/ value pair's key
		 * @param value	The value associated with the key
		 */
		override protected function setKeyValuePair(key:*, value:*):void
		{
			if (!(value is _valueType))
			{
				throw new Error("Value is not of type " + _valueType + ": " + value);
			}
			else
			{
				super.setKeyValuePair(key, value);
			}
		}		
	}
}
