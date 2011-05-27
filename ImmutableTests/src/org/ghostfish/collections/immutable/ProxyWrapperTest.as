package org.ghostfish.collections.immutable
{
	import flexunit.framework.Assert;

	public class ProxyWrapperTest extends ProxyWrapper
	{		
		[Test]
		public function testBracketsToAccessData():void
		{
			data = [1234, 5678];
			Assert.assertEquals(1234, this[0]);
			Assert.assertEquals(5678, this[1]);
			Assert.assertEquals(5678, this["1"]);
		}
		
		[Test(expects="Error")]
		public function testBracketsToAccessDataOutOfBounds():void
		{
			data = [1234, 5678];
			Assert.assertEquals(1234, this[2]);
		}
		
		[Test(expects="Error")]
		public function testBracketsToAccessDataInvalid1():void
		{
			data = [1234, 5678];
			Assert.assertEquals(1234, this[-1]);
		}
		
		[Test(expects="Error")]
		public function testBracketsToAccessDataInvalid2():void
		{
			data = [1234, 5678];
			Assert.assertEquals(1234, this[0.5]);
		}
		
		[Test(expects="Error")]
		public function testBracketsToAccessDataInvalid3():void
		{
			data = [1234, 5678];
			Assert.assertEquals(1234, this["a"]);
		}
		
		[Test]
		public function testDeleteNotAllowed():void
		{
			var txt:String = "";
			data = [1234, 5678];
			Assert.assertEquals(2, data.length);
			Assert.assertEquals(2, length);
			try
			{
				delete this[0];
			}
			catch(e:Error)
			{
				txt = e.message;
			}
			Assert.assertTrue(txt != "");
			Assert.assertEquals(2, data.length);
			Assert.assertEquals(2, length);
		}
		
		[Test]
		public function testChangeNotAllowed():void
		{
			var txt:String = "";
			data = [1234, 5678];
			try
			{
				this[0] = 2345;
			}
			catch(e:Error)
			{
				txt = e.message;
			}
			
			Assert.assertTrue(txt != "");
			Assert.assertEquals(1234, this[0]);
			Assert.assertEquals(5678, this[1]);
			Assert.assertEquals(2, data.length);
			Assert.assertEquals(2, length);
		}
		
		[Test]
		public function testForEach():void
		{
			var counter:int = 9;
			data = [9, 8, 7, 6, 5];
			for each (var n:int in this)
			{
				Assert.assertEquals(counter--, n);
			}
		}
		
		[Test]
		public function testFor():void
		{
			var counter:int = 0;
			data = [9, 8, 7, 6, 5];
			for (var s:String in this)
			{
				Assert.assertEquals("" + counter, s);
				Assert.assertEquals(this[s], data[counter]);
				counter++;
			}
		}
		
		[Test]
		public function testToArray():void
		{
			data = ["la", "doh", 1, 3];
			var data2:Array = toArray();
			Assert.assertEquals("la", data2[0]);
			data2[0] = "oh no";
			Assert.assertEquals("la", data[0]);
			Assert.assertEquals("la", this[0]);
		}
	}
}