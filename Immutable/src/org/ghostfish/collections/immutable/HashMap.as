package org.ghostfish.collections.immutable
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * This in an immutable version of the Dictionary class (though it doesn't
	 * support using object references as keys)
	 * <p>
	 * Key/ value pairs may be added to a hash map, but they cannot not be removed, nor 
	 * can the value associated with a key be changed.
	 * </p><p>
	 * For true immutablity, the map may be locked, which then prevents
	 * new key/ value pairs being added to it. A key is supplied to the
	 * lock caller, which may be used to unlock the map later. </p>
	 */
	public dynamic class HashMap extends Proxy
	{
		/**
		 * @private
		 * 
		 * The key used to lock the map. See the lock() and unlock() methods
		 */
		protected var lockThing:Object = null;
		/**
		 * @private
		 * 
		 * The map's local data store
 		 */
		protected var data:Object;
		/**
		 * @private
		 * 
		 * Used for iterating over the key/ value pairs 
		 */
		protected var indexes:Array;
		
		/**
		 * Creates a new (empty) hashmap.
		 */
		function HashMap()
		{
			data = {};
			indexes = [];
		}

		/**
		 * Locks the hashmap, so that no further key/ value pairs can be added to it
		 * 
		 * @return 	The key, which is required for unlocking the hashmap.
		 * 
		 * @Throws	Error	Throws an error if the hashmap is already locked
		 */
		public function lock():*
		{
			if (lockThing != null)
			{
				throw new Error("Hashmap is already locked");
			}
			else
			{
				lockThing = {};
				return lockThing;
			}
		}
		
		/**
		 * Unlocks the hashmap, allowing new key/ value pairs to be added once more.
		 * 
		 * @param thing	The key supplied by the call to lock()
		 * 
		 * @Throws	Error	Throws an error if the key is not that supplied by lock()
		 */
		public function unlock(thing:*):void
		{
			if (thing === lockThing)
			{
				lockThing = null;
			}
			else
			{
				throw new Error("Hashmap cannot be unlocked with supplied key: " + thing);
			}
		}

		/**
		 * Runs the callback function against each key/ value pair in the hashmap.
		 * 
		 * @param callBack	Reference to a function with the signature <code>function(key:~~, value:~~):void</code>
		 */
		public function forEach(callBack:Function):void
		{
			for each (var key:* in indexes)
			{
				callBack(key, data[key]);
			}
		}
		
		/**
		 * Tests whether the specified key exists in the hash map
		 *  
		 * @param someKey The key to be tested
		 * 
		 * @return True if the key exists; false otherwise. 
		 */
		public function keyExists(someKey:String):Boolean
		{
			for each (var key:* in indexes)
			{
				if (key == someKey)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * @private
		 * 
		 * Gets a value for the specified key. Used via the map[key] notation
		 */
		override flash_proxy function getProperty(key:*):*
		{
			if (data.hasOwnProperty(key))
			{
				return data[key];
			}
			else
			{
				throw new Error("No such key: " + key);
			}
		}
		
		/**
		 * @private
		 * 
		 * Sets a new key/ value pair unless locked. Set using the map[key] = value notation
		 * 
		 * @Throws Error	Throws an error if the hashmpa is locked, or if the key already exists
		 */
		override flash_proxy function setProperty(key:*, value:*):void
		{
			setKeyValuePair(key, value);
		}
		
		protected function setKeyValuePair(key:*, value:*):void
		{
			if (lockThing != null)
			{
				throw new Error("Hashmap is locked and so cannot be modified in any way");
			}
			else if (data[key] != undefined)
			{
				throw new Error("Key already exists: " + key);
			}
			else
			{
				data[key] = value;
				indexes.push(key);
			}
		}
		
		/**
		 * @private
		 * 
		 * @param key The key to be deleted. Used via delete map.key notation.
		 * 
		 * @throws	Error	Always throws an error as deleting keys is not supported
		 */
		override flash_proxy function deleteProperty(key:*):Boolean
		{
			throw new Error("Cannot delete key/ value pairs from a Hashmap");
		}

		/**
		 *  @private
		 */
		override flash_proxy function nextNameIndex(i:int):int
		{
			return i >= 0 && i < indexes.length ? i + 1 : 0;
		}
		
		/**
		 *  @private
		 */
		override flash_proxy function nextName(i:int):String
		{
			return indexes[i-1].toString();
		}
		
		/**
		 *  @private
		 */
		override flash_proxy function nextValue(i:int):*
		{
			var j:int = i-1;
			if (j >= 0 && j < indexes.length)
			{
				return data[indexes[j]];
			}
			else
			{
				throw new Error("Out of bounds " + i);
			}
		}    
	}
}
