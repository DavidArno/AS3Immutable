package org.ghostfish.collections.immutable.hashMapTests
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.ghostfish.collections.immutable.HashMap;

	/**
	 * Tests that key/ value pairs can be added to a HashMap and the correct
	 * value can be extracted for a given key.
	 */
	public class HashMapAddEditReadTests
	{
		private static const AKEY_VALUE:int = 1;
		private static const BKEY_VALUE:int = 2;
		private static const KEYOBJ_VALUE:int = 3;
		
		/**
		 * The HashMap under test 
		 */
		protected var hash:HashMap;
		
		/**
		 * Object used as a key. See keyObj2 for more details.
		 */
		protected var keyObj1:Object;
		
		/**
		 * Due to limitations of the Proxy class, the keys are used by name,
		 * not by reference. So toString for an Object returns the same text
		 * regardless of the object and its content. This field is used to
		 * test that this documented feature works as described. See testKeyObj2()
		 * for more details.
		 */
		protected var keyObj2:Object;
		
		[Before]
		/**
		 * Initialisation run before each test. Sets up the hash map
		 * ready for test.
		 * <p>
		 * Three values are written to the hash map. The last one
		 * uses an Object instance, rather than a string, in
		 * order to facilitate testing that the claim that keys
		 * are converted to strings holds true. See testKeyObj2()
		 * for more details on this point
		 * </p>
		 */
		public function setUp():void
		{
			hash = new HashMap();
			keyObj1 = {};
			keyObj2 = {};
			hash.aKey = AKEY_VALUE;
			hash.bKey = BKEY_VALUE;
			hash[keyObj1] = KEYOBJ_VALUE;
		}
		
		[Test]
		/**
		 * Tests that the value associated with the key aKey can be 
		 * successfully read from the HashMap.
		 */
		public function testAKey():void
		{
			assertEquals(AKEY_VALUE, hash.aKey);
		}
		
		[Test]
		/**
		 * Tests that the value associated with the key bKey can be 
		 * successfully read from the HashMap via hash.bKey notation.
		 */
		public function testBKeyDirect():void
		{
			assertEquals(BKEY_VALUE, hash.bKey);
		}
		
		[Test]
		/**
		 * Tests that the value associated with the key bKey can be 
		 * successfully read from the HashMap via hash["bKey"] notation.
		 */
		public function testBKeyIndirect():void
		{
			assertEquals(BKEY_VALUE, hash["bKey"]);
		}
		
		[Test]
		/**
		 * Tests that the value associated with the key keyObj1 can be 
		 * successfully read from the HashMap.
		 */
		public function testKeyObj1():void
		{
			assertEquals(KEYOBJ_VALUE, hash[keyObj1]);
		}
		
		[Test]
		/**
		 * Tests that the value associated with the key keyObj1 can be 
		 * read from the HashMap using keyObj2, due to keys being
		 * name-based, not reference-based.
		 */
		public function testKeyObj2():void
		{
			assertEquals(KEYOBJ_VALUE, hash[keyObj2]);
		}
		
		[Test]
		/**
		 * Tests that an existing key can be comfirmed to
		 * exist via the keyExists() method.
		 */
		public function testKeyExists():void
		{
			assertTrue(hash.keyExists("bKey"));
		}
		
		[Test]
		/**
		 * Tests that the keyExists() method correctly
		 * returns false for a non-existent key enquiry.
		 */
		public function testNonexistentKeyDoesntExist():void
		{
			assertFalse(hash.keyExists("noSuchKey"));
		}

		[Test(expects="Error")]
		/**
		 * Tests that an error is thrown when a non-existent key is
		 * accessed.
		 */
		public function testKeyNotFound():void
		{
			var o:* = hash.doesntExist;
		}
		
		[Test(expects="Error")]
		/**
		 * Tests that an error is thrown when an attempt is made to 
		 * modify the value of an existing key.
		 */
		public function testAddToExistingFails():void
		{
			hash.aKey = 0;
		}
		
		[Test(expects="Error")]
		/**
		 * Tests that an Error is thrown when attempting to delete a key.
		 */
		public function testDelete():void
		{
			delete hash.aKey;
		}
		
		[Test]
		/**
		 * Tests that the number of items in the hash map is correctly 
		 * reported via the length accessor.
		 */
		public function testLength():void
		{
			assertEquals(3, hash.length);
		}
	}
}