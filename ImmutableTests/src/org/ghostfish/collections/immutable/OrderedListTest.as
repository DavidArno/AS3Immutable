package org.ghostfish.collections.immutable
{
	import flexunit.framework.Assert;

	public class OrderedListTest
	{		
		[Test]
		public function testProxyStuff1():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			
			Assert.assertEquals(1, l[0]);
			Assert.assertEquals("bah", l[3]);
			
			var str1:String = "";
			var str2:String = "";
			
			for each (var n:* in l)
			{
				str1 += n;
			}
			
			for (var s:String in l)
			{
				str2 += s;
			}
			
			Assert.assertEquals("14labah[object Object]", str1);
			Assert.assertEquals("01234", str2);
		}
		
		[Test(expects="Error")]
		public function testProxyStuff2():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			var x:* = l[-1];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff3():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			var x:* = l["a"];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff4():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			var x:* = l[0.5];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff5():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			var x:* = l[5];
		}
		
		[Test(expects="Error")]
		public function testProxyStuff6():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			l[0] = 2;
		}
		
		[Test(expects="Error")]
		public function testProxyStuff7():void
		{
			var l:OrderedList = new OrderedList(1, 4, "la", "bah", {});
			delete l[1];
		}
		
		[Test]
		public function testToString():void
		{
			var l:OrderedList = new OrderedList("oh", "me", "oh", "my");
			Assert.assertEquals("[oh,me,oh,my]", l.toString());
		}
		
		[Test]
		public function testArrayFuncs():void
		{
			var array1:Array = [1,2,3,4];
			
			var l:OrderedList = OrderedList.fromArray(array1);
			array1[2] = 5;
			
			var array2:Array = l.toArray();
			
			Assert.assertEquals(5, array1[2]);
			Assert.assertEquals(3, array2[2]);
			
			array2[2] = 6;
			var array3:Array = l.toArray();
			
			Assert.assertEquals(3, array3[2]);
			Assert.assertEquals(6, array2[2]);
		}
		
		[Test]
		public function everyTest():void
		{
			var s1:String = "";
			var s2:String = "";
			
			var l:OrderedList = new OrderedList(0,1,2,3,4);
			l.every(function(e:*, i:int):Boolean { s1 += "" + e + i; return true; });
			Assert.assertEquals("0011223344", s1);	
			
			l = new OrderedList(1,2,3,"4");
			l.every(function(e:*, i:int):Boolean 
			{ 
				if (e is int)
				{
					s2 += "" + e + i;
					return true;
				}	 
				else
				{
					return false;
				}
			});
			Assert.assertEquals("102132", s2);
		}
		
		[Test]
		public function testForEach():void
		{
			var s1:String = "";
			var s2:String = "";
			
			var l:OrderedList = new OrderedList(0,1,2,3,4);
			l.forEach(function(e:*, i:int):void { s1 += "" + e + i; });
			Assert.assertEquals("0011223344", s1);	
			
			l = new OrderedList(1,2,3,"4",5);
			l.forEach(function(e:*, i:int):void 
			{
				if (e is int)
				{
					s2 += "" + e + i;
				}	 
			});
			Assert.assertEquals("10213254", s2);
		}
		
		[Test]
		public function testIndexOf():void
		{
			var l:OrderedList = new OrderedList(0, 1, 2, 1, 3, 4, 1);
			var s1:String = "";
			var index:int = 0;
			
			while (index >= 0)
			{
				index = l.indexOf(1, ++index);
				s1 += index;
			}
			
			Assert.assertEquals("136-1", s1);
			
			l = new OrderedList(1, 2, 3);
			Assert.assertEquals(0, l.indexOf(1));
		}
		
		[Test]
		public function testLastIndexOf():void
		{
			var l:OrderedList = new OrderedList(0, 1, 2, 1, 3, 4, 1, 1);
			var s1:String = "";
			var index:int = 8;
			
			while (index >= 0)
			{
				index = l.lastIndexOf(1, --index);
				s1 += index;
			}
			
			Assert.assertEquals("7631-1", s1);
		}
	}
}