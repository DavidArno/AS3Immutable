package org.ghostfish.collections.immutable.hashMapTests
{
	import flexunit.framework.Assert;
	
	import org.ghostfish.collections.immutable.HashMap;
	
	public class HashMapLockTests
	{
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
		public function testLockAndAddCausesError():void
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
		public function testUnlockWithWrongKeyCausesError():void
		{
			var m:HashMap = new HashMap();
			var key:* = m.lock();
			m.unlock(key.toString());
		}
		
		[Test(expects="Error")]
		public function testUnlockWithoutLockCausesError():void
		{
			var m:HashMap = new HashMap();
			m.unlock(m);
		}
	}
}