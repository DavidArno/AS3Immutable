package flexUnitTests
{
	import org.ghostfish.collections.immutable.HashMapTest;
	import org.ghostfish.collections.immutable.OrderedListTest;
	import org.ghostfish.collections.immutable.ProxyWrapperTest;
	import org.ghostfish.collections.immutable.TupleTest;
	import org.ghostfish.collections.immutable.TypedHashMapTest;
	import org.ghostfish.collections.immutable.TypedOrderedListTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class Suite
	{
		public var proxyTests:ProxyWrapperTest = new ProxyWrapperTest();
		public var tupleTests:TupleTest = new TupleTest();
		public var listTests:OrderedListTest = new OrderedListTest();
		public var typedListTests:TypedOrderedListTest = new TypedOrderedListTest();
		public var hashMapTests:HashMapTest = new HashMapTest();
		public var typedHashMapTests:TypedHashMapTest = new TypedHashMapTest();
	}
}