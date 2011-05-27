package org.ghostfish.collections.immutable
{
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;

	public class TupleTest
	{
		[Test]
		public function testProxyStuff1():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			
			Assert.assertEquals(1, t[0]);
			Assert.assertEquals("bah", t[3]);

			var str1:String = "";
			var str2:String = "";
			
			for each (var n:* in t)
			{
				str1 += n;
			}
			
			for (var s:String in t)
			{
				str2 += s;
			}
			
			Assert.assertEquals("14labah[object Object]", str1);
			Assert.assertEquals("01234", str2);
		}
		
		[Test(expects="Error")]
		public function testProxyStuff2():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t[-1];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff3():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t.a;
		}
		
		public function testProxyStuff3a():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t._a;
		}
		
		public function testProxyStuff3b():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t._6;
		}
		
		[Test(expects="Error")]
		public function testProxyStuff4():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t[0.5];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff5():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			var x:* = t[5];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff6():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			t[0] = 2;
		}
		
		[Test(expects="Error")]
		public function testProxyStuff7():void
		{
			var t:Tuple = new Tuple(1, 4, "la", "bah", {});
			delete t[1];
		}
		
		[Test]
		public function testToString():void
		{
			var t:Tuple = new Tuple("long", "long", "time", "ago");
			Assert.assertEquals("(long,long,time,ago)", t.toString());
		}
		
		[Test]
		public function testArrayFuncs():void
		{
			var array1:Array = [1,2,3,4];

			var t:Tuple = Tuple.fromArray(array1);
			array1[2] = 5;

			var array2:Array = t.toArray();
			
			Assert.assertEquals(5, array1[2]);
			Assert.assertEquals(3, array2[2]);

			array2[2] = 6;
			var array3:Array = t.toArray();
			
			Assert.assertEquals(3, array3[2]);
			Assert.assertEquals(6, array2[2]);
		}
		
		[Test]
		public function testTupleParams():void
		{
			var t:Tuple = new Tuple(1,2,3);
			Assert.assertEquals(1, t[0]);
			Assert.assertEquals(1, t._1);
		}
	}
}