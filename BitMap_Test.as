package 
{
	public class BitMap_Test
	{
		public function BitMap_Test()
		{
			var bm:BitMap = new BitMap(64);
			reset(bm);
			trace(bm.snapshot());
			
		
			reset(bm);
			bm.bitShift(2);
			trace(bm.snapshot());
		}
		
		private function reset(map:BitMap):void {
			for (var i:int = 0; i < map.size; ++i) {
				i % 2 == 0?map.bitSet(i):map.bitClear(i);
			}
		}
	}
}