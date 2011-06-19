package org.ghostfish.collections.immutable
{
	import org.ghostfish.collections.immutable.hashMapTests.HashMapAddEditReadTests;
	import org.ghostfish.collections.immutable.hashMapTests.HashMapForEachTests;
	import org.ghostfish.collections.immutable.hashMapTests.HashMapLockTests;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	/**
	 * Suite of test cases for the HashMap class.
	 * <p>
	 * Via the public var declarations, it informs the test runner of the 
	 * hash map add/edit/read tests, foreach tests and lock tests test case
	 * classes.
	 * </p>
	 */
	public class HashMapTestSuite
	{
		public var hashMapAddEditReadTestSet:HashMapAddEditReadTests;
		public var hashMapForEachTestSet:HashMapForEachTests;
		public var hashMapLcokTestSet:HashMapLockTests;
	}
}