package org.ghostfish.collections.immutable
{
	import flexunit.framework.Assert;
	
	public class TypedHashMapTest
	{
		[Test]
		public function testTypingPasses():void
		{
			var m:TypedHashMap = new TypedHashMap(String);
			m.key1 = "a";
			
			Assert.assertEquals("a", m["key1"]);
			Assert.assertEquals("a", m.key1);
		}
		
		[Test(expects="Error")]
		public function testTypingFails1():void
		{
			var m:TypedHashMap = new TypedHashMap(String);
			m.key1 = 1;
		}
		
		[Test(expects="Error")]
		public function testTypingFails2():void
		{
			var m:TypedHashMap = new TypedHashMap(null);
		}
	}
}