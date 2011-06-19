package org.ghostfish.collections.immutable.hashMapTests
{
	import org.flexunit.asserts.assertEquals;
	import org.ghostfish.collections.immutable.HashMap;

	/**
	 * Tests for for, for each and the forEach() method with
	 * hash maps.
	 */
	public class HashMapForEachTests
	{
		/**
		 * The hash map under test.
		 */
		protected var hashmap:HashMap;
		
		[Before]
		/**
		 * Setup that is run before each test. Sets up a five element hashmap.
		 */
		public function setup():void
		{
			hashmap = new HashMap();
			hashmap.key1 = 1;
			hashmap.key2 = 2;
			hashmap.key3 = 3;
			hashmap.key4 = 4;
			hashmap.key5 = 5;
		}
		
		[Test]
		/**
		 * Tests that the values in a hash map can be iterated over in the
		 * same order as they were added to the hash map
		 */
		public function testForEach():void
		{
			var str:String = "";
			
			for each (var n:int in hashmap)
			{
				str += n;
			}
			
			assertEquals("12345", str);
		}
		
		[Test]
		/**
		 * Tests that the keys in a hash map can be iterated over in the
		 * same order as they were added to the hash map
		 */
		public function testFor():void
		{
			var str:String = "";
			
			for (var s:String in hashmap)
			{
				str += s;
			}
			
			assertEquals("key1key2key3key4key5", str);
		}
		
		[Test]
		/**
		 * Tests that a hash map's forEach() method can be used to
		 * process all the key/value pairs of a hashmap in the
		 * same order as they were added to the hash map.
		 */
		public function testForEachMethod():void
		{
			var str:String = "";
			var iterationFunction:Function =
				function(key:*, value:*):void
				{
					str += key + ":" + value + ".";
				}
			
			hashmap.forEach(iterationFunction);		
			
			assertEquals("key1:1.key2:2.key3:3.key4:4.key5:5.", str);
		}		
	}
}