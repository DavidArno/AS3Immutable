package org.ghostfish.collections.immutable
{
	/**
	 * A tuple is an immutable, ordered list of zero or more values of mixed types. 
	 * It is ideally suited to returning a set of many values from a method.
	 * <p>
	 * Expressing that more clearly, but less succinctly, a tuple can be viewed as
	 * a functionally cut-down version of the Array type, with one important distinction:
	 * the elements of a tuple are fixed when the tuple is created. Consider the following 
	 * example tuple: ("1", 2, [3]), which can be defined in the following fashion:</p>
	 * <p><code>var t:Tuple = new Tuple("1", 2, [3]);</code></p>
	 * <p>
	 * The elements of the tuple can be accessed as if its an array, so 
	 * <code>t[0]</code> would return the value "1" for example. Unlike an array
	 * though, the following lines of code would all result in exceptions</p>
	 * <p><listing>
	 * t[0] = 4;
	 * trace(t[3]);
	 * t[3] = 0;</listing></p>
	 * <p>
	 * In the first case an attempt is made to modify an existing value, in the second
	 * an attempt is made to read a non-existent element and in the third case, an
	 * attempt is made to add a new element to the tuple. None of these actions is
	 * permitted.</p>
	 * <p>Tuples also allow the elements to be accessed using _&lt;n&gt; notation, where
	 * n is a positive integer. It is important to note that t[0] and t._1 access
	 * the same element.
	 * </p>
	 */
	public dynamic class Tuple extends ProxyWrapper
	{
		/**
		 * Create a new tuple of n-length (ie 0 or more elements)
		 */
		function Tuple(...args)
		{
			initialiseFromArray(args);
		}
		
		/**
		 * Generate an array from the tuple.
		 * <p>Note, this is a copy of the original tuple data. The
		 * generated array can be modified without affecting the tuple.
		 * </p>
		 * 
		 * @return An array 
		 */
		public override function toArray():Array
		{
			return super.toArray();
		}

		/**
		 * The number of items in the tuple
		 */
		public override function get length():int
		{
			return super.length;
		}

		/**
		 * Generate a tuple from an array.
		 * <p>Note, the tuple copies the array data so the
		 * array can subsequently be modified without affecting the tuple.
		 * </p>
		 * @param arrayData	The array data used to generate the tuple
		 * 
		 * @return	An instance of Tuple
		 */
		public static function fromArray(arrayData:Array):Tuple
		{
			var t:Tuple = new Tuple([]);
			t.initialiseFromArray(arrayData);
			
			return t;
		}
		
		/**
		 * Generates a string representation of the tuple
		 * 
		 * @return The string representation of the tuple
		 */
		public function toString():String
		{
			return "(" + data.toString() + ")";
		}

		/**
		 * @private
		 * 
		 * This handles obj[n] and obj.n type invocations. "n" is passed as name here
		 */
		protected override function getPropertyExtended(name:*):*
		{
			var lname:String = localName(name);
			
			if (lname.charAt(0) == "_")
			{
				var i:int = index(lname.substr(1));
				if(i >= 1)
				{
					return super.getPropertyExtended(i-1);
				}
				else
				{
					throw new Error("_ parameters must be in range 1 .. tuple.length");
				}
			}
			else
			{
				return super.getPropertyExtended(name);
			}
		}
	}
}