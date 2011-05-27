package org.ghostfish.collections.immutable
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * @private
	 * 
	 * This code is inspired by that from ListCollectionView, with the 
	 * horrible copy & pasted code contained therein tidied up.
	 */
	internal class ProxyWrapper extends Proxy
	{
		/**
		 * The data store for the immutable type. Yep, it's just an array under the hood.
		 */
		protected var data:Array = [];
		
		/**
		 * Generates an array from the data store
		 *  
		 * @return An array (a copy of the orginal, not a reference to it)
		 */
		public function toArray():Array
		{
			var array:Array = [];
			data.forEach(function(item:*, i:int, _:Array):void { array.push(item); });
			
			return array;
		}

		/**
		 * The number of items in the data store 
		 */
		public function get length():int
		{
			return data.length;
		}

		/**
		 * @private
		 * 
		 * This handles obj[n] type invocations. "n" is passed as name here
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return getPropertyExtended(name);
		}

		/**
		 * @private
		 * 
		 * "Bodge" to get around a possible mxmlc bug. Cannot do
		 * override flash_proxy function getProperty(name:*):* in
		 * Tuple, so have to provide this method for overriding
		 */
		protected function getPropertyExtended(name:*):*
		{
			var i:int = index(localName(name));
			
			if (i == -1)
			{
				throw new Error("Unknown property " + name);
			}
			else if (!withinBounds(i))
			{
				throw new Error("Out of bounds " + name);
			}
			else
			{
				return data[i];
			}
		}
		
		/**
		 * @private
		 * 
		 * We are immutatble. No changes shall be allowed!
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new Error("The properties of an immutable collection canot be changed: " + name);
		}
		
		/**
		 * @private
		 * 
		 * We are immutatble. No changes shall be allowed!
		 */
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			throw new Error("The properties of an immutable collection canot be deleted: " + name);
		}

		/**
		 * @private
		 * 
		 * @param name The property name that should be tested for existence.
		 */
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return withinBounds(index(localName(name)));;
		}

		/**
		 * @private
		 * 
		 * Used with for in and for each in
		 */
		override flash_proxy function nextNameIndex(i:int):int
		{
			return withinBounds(i) ? i + 1 : 0;
		}
		
		/**
		 * @private
		 * 
		 * Used with for in and for each in
		 */
		override flash_proxy function nextName(i:int):String
		{
			return (i-1).toString();
		}
		
		/**
		 * @private
		 * 
		 * Used with for in and for each in
		 */
		override flash_proxy function nextValue(i:int):*
		{
			var j:int = i-1;
			if (withinBounds(j))
			{
				return data[j];
			}
			else
			{
				throw new Error("Out of bounds " + i);
			}
		}    

		/**
		 * Handles extracting the name string from XML data
		 *  
		 * @param name The raw name
		 * 
		 * @return 	The name string 
		 */
		protected function localName(name:*):String
		{
			return name is QName ? name.localName : name;
		}
		
		/**
		 * Determines if name is a valid index value
		 * 
		 * @param name The value to be analysed
		 * 
		 * @return 0+ if a valid index; -1 otherwise
		 */
		protected function index(name:*):int
		{
			var i:int = -1;
			
			try
			{
				var n:Number = parseInt(String(name));
				if (String(name).indexOf(".") == -1 && !isNaN(n) && n >= 0)
				{
					i = int(n);
				}
			}
			catch (e:*) {}
			
			return i;
		}
		
		/**
		 * Determines if 0 <= index < data set length
		 *  
		 * @param i	The index to test
		 * 
		 * @return	True if within bounds; false otherwise 
		 */
		protected function withinBounds(i:int):Boolean
		{
			return i >= 0 && data != null && i < data.length;
		}

		/**
		 * Populates the data store with a copy of an array
		 * 
		 * @param array The array to be copied
		 */
		protected function initialiseFromArray(array:Array):void
		{
			data = [];
			var robustArray:Array = array == null ? [] : array;
			robustArray.forEach(function(item:*, i:int, _:Array):void { data.push(item); });
		}
	}
}