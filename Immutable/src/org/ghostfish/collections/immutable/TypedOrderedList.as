package org.ghostfish.collections.immutable
{
	/**
	 * Extends the functionality of the OrderedList class by imposing a
	 * requirement that all the values must be of one type.
	 * <p>
	 * See the OrderedList class for full list of the methods supported.</p>
	 */
	public class TypedOrderedList extends OrderedList
	{
		/**
		 * @private 
		 */
		protected var _type:Class;
		
		/**
		 * Creates a new ordered list of the specified type.
		 *  
		 * @param type		The type that all values must comply with.
		 * @param args		The set of values for this list
		 * 
		 * @throws	Error	Throws an error if the values of the array are not all of the 
		 *					specified type
		 */
		public function TypedOrderedList(type:Class, ...args)
		{
			super();

			checkTypes(type, args);
			_type = type;
			initialiseFromArray(args);
		}
		
		/**
		 * The type that all values of this list comply with
		 */
		public function get type():Class { return _type; }
		
		/**
		 * Creates a typed ordered list from an array
		 * 
		 * @param 	type		The type that all values must comply with.
		 * @param 	arrayData	The source array
		 * 
		 * @return	a typed ordered list
		 * 
		 * @throws	Error		Throws an error if the values of the array are not all of the 
		 *						specified type
		 */
		public static function fromArray(type:Class, arrayData:Array):TypedOrderedList
		{
			var l:TypedOrderedList = new TypedOrderedList(type);

			l.checkTypes(type, arrayData);
			l._type = type;
			l.initialiseFromArray(arrayData);
			
			return l;
		}
		
		/**
		 * @private 
		 * 
		 * Checks that all the values of an array are of the specified type.
		 * 
		 * @param 	type	The type that all values must comply with
		 * @param 	args	The set of values to be checked
		 * 
		 * @throws	Error	Throws an error is any of the values in the array are not
		 * 					of the specified type
		 */
		protected function checkTypes(type:Class, args:Array):void
		{
			if (type == null)
			{
				throw new Error("type must be a valid data type");
			}
			else
			{
				for each (var item:* in args)
				{
					if (!(item is type))
					{
						throw new Error("Item " + item + " is not of type " + type);
					}
				}
			}
		}
	}
}