package org.ghostfish.collections.immutable
{
	import flexunit.framework.Assert;
	
	public class HashMapTest
	{
		[Test]
		public function testAddOK():void
		{
			var m:HashMap = new HashMap();
			var keyObj1:Object = {};
			var keyObj2:Object = {};
			m.aKey = 1;
			m.bKey = 2;
			m[keyObj1] = 3;
			
			Assert.assertEquals(1, m.aKey);
			Assert.assertEquals(2, m["bKey"]);
			Assert.assertEquals(3, m[keyObj1]);
			Assert.assertEquals(3, m[keyObj2]);
		}
		
		[Test(expects="Error")]
		public function testAddToExistingFails():void
		{
			var m:HashMap = new HashMap();
			var keyObj1:Object = {};
			var keyObj2:Object = {};
			m.aKey = 1;
			m.bKey = 2;
			m[keyObj1] = 3;
			m[keyObj2] = 4;
		}
		
		[Test(expects="Error")]
		public function testKeyNotFound():void
		{
			var m:HashMap = new HashMap();
			var o:* = m.doesntExist;
		}
		
		[Test(expects="Error")]
		public function testDelete():void
		{
			var m:HashMap = new HashMap();
			m.aKey = 1;
			delete m.aKey;
		}
		
		[Test]
		public function testForEach():void
		{
			var m:HashMap = new HashMap();
			var str:String = "";
			m.key1 = 1;
			m.key2 = 2;
			m.key3 = 3;
			m.key4 = 4;
			m.key5 = 5;
			
			for each (var n:int in m)
			{
				str += n;
			}
			
			Assert.assertEquals("12345", str);
		}
		
		[Test]
		public function testFor():void
		{
			var m:HashMap = new HashMap();
			var str:String = "";
			m.key1 = 1;
			m.key2 = 2;
			m.key3 = 3;
			m.key4 = 4;
			m.key5 = 5;
			
			for (var s:String in m)
			{
				str += s;
			}
			
			Assert.assertEquals("key1key2key3key4key5", str);
		}
		
		[Test]
		public function testLockAndUnlock():void
		{
			var m:HashMap = new HashMap();
			var key:* = m.lock();
			m.unlock(key);
			
			m.aKey = "a";
			Assert.assertEquals("a", m.aKey);
		}
		
		[Test(expects="Error")]
		public function testLockAndAdd():void
		{
			var m:HashMap = new HashMap();
			var key:* = m.lock();
			
			m.aKey = "a";
		}
		
		[Test(expects="Error")]
		public function testLockAndLock():void
		{
			var m:HashMap = new HashMap();
			var key:* = m.lock();
			key = m.lock();
		}
		
		[Test(expects="Error")]
		public function testUnlock1():void
		{
			var m:HashMap = new HashMap();
			var key:* = m.lock();
			m.unlock(key.toString());
		}
		
		[Test(expects="Error")]
		public function testUnlock2():void
		{
			var m:HashMap = new HashMap();
			m.unlock(m);
		}
		
		[Test]
		public function testForEachMethod():void
		{
			var m:HashMap = new HashMap();
			var str:String = "";
			m.k1 = "a1";
			m.k2 = "b2";
			m.k3 = "c3";
			m.k4 = "d4";
			m.k5 = "e5";
			
			m.forEach(function(key:*, value:*):void
					  {
						  str += key + value;
					  });		
			
			Assert.assertEquals("k1a1k2b2k3c3k4d4k5e5", str);
		}
		
		[Test]
		public function testKeyExists():void
		{
			var m:HashMap = new HashMap();
			m.a1 = "la";
			
			Assert.assertTrue(m.keyExists("a1"));
			Assert.assertFalse(m.keyExists("a2"));
		}
	}
}