package org.ghostfish.collections.immutable
{
	/**
	 * OrderedList is an immutable version of the Array class, which
	 * implements those aspects of the Array's functionality that makes sense for an
	 * immutable collection.
	 * <p>
	 * The elements of an ordered list can be accessed just like an array:<br/>
	 * <listing>
	 * var list:OrderedList = new OrderedList("a", "b", "c");
	 * 
	 * var x:String = list[1]; // Sets x to "b"
	 *
	 * for (var i:int = 0; i &lt; list.length; i++)
	 * {
	 *     var y:String = list[i];	// Set y to "a", "b", &amp; "c" respectively
	 * }
	 * 
	 * for each (var s:String in list)
	 * {
	 *     var z:String = s; // Set z to "a", "b", &amp; "c" respectively
	 * }
	 * </listing>
	 * </p>
	 */
	public class OrderedList extends ProxyWrapper
	{
		/**
		 * Creates a new ordered list (immutable array)
		 * 
		 * @param args	Thye set of values used to populate the list
		 */
		public function OrderedList(...args)
		{
			initialiseFromArray(args);
		}
		
		/**
		 * Creates an ordered list from an array
		 * 
		 * @param 	arrayData	The source array
		 * @return	an ordered list
		 */
		public static function fromArray(arrayData:Array):OrderedList
		{
			var l:OrderedList = new OrderedList();
			l.initialiseFromArray(arrayData);
			
			return l;
		}
				
		/**
		 * Calls callBack() against each value in the list in turn. Stops
		 * when either a call to callBack returns false, or all values have
		 * been called. The former takes precedence.
		 * 
		 * @param callBack 	A function with the signature:
		 * 					<code>function(element:~~, index:int):Boolean</code>.
		 * 
		 * @return	False if callBack returns false at some point;
		 * 			otherwise true; 
		 */
		public function every(callBack:Function):Boolean
		{
			return data.every(function (item:*, index:int, _:Array):Boolean { return callBack(item, index); });
		}
		
		/**
		 * Calls callBack() against each value in the list in turn.
		 * 
		 * @param callBack	A function with the signature:
		 * 					<code>function(element:~~, index:int):Boolean</code>.
		 */
		public function forEach(callBack:Function):void
		{
			data.forEach(function (item:*, index:int, _:Array):void { callBack(item, index); });
		}
		
		/**
		 * Finds the first element in the list that matches the specified
		 * item.
		 * 
		 * @param item	The item to be matched
		 * @param from	The element to start searching from. If not specified,
		 * 				then the search starts from element 0.
		 * 
		 * @return		The element number of the first match if there is one;
		 * 				otherwise -1.  
		 */
		public function indexOf(item:*, from:uint = 0):int
		{
			return data.indexOf(item, from);
		}
		
		/**
		 * Finds the last element in the list that matches the specified
		 * item.
		 * 
		 * @param item	The item to be matched
		 * @param from	The element to start searching from. If not specified,
		 * 				then the search starts from the last element.
		 * 
		 * @return		The element number of the last match if there is one;
		 * 				otherwise -1.
		 */
		public function lastIndexOf(item:*, from:int = 0x7FFFFE):int
		{
			return data.lastIndexOf(item, from);
		}
		
		/**
		 * Creates a string representation of the list.
		 * 
		 * @return [elem1,elem2,...,elemN]
		 */
		public function toString():String
		{
			return "[" + data.toString() + "]";
		}
		
		/**
		 * Generates an array from the list
		 *  
		 * @return An array of values corresponding to the list's values
		 */
		public override function toArray():Array
		{
			return super.toArray();
		}
	}
}