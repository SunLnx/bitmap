package 
{
    public class BitMap_Test
    {
        public function BitMap_Test()
        {
            var bm:BitMap = new BitMap(9);
            //for (var i:int = 0; i < bm.size; ++i) {
                //trace(bm.bit(i), bm.bitSet(i), bm.bit(i));
            //}
            //for (var i:int = 0; i < bm.bytes.length;++i) {
            //    trace(bm.byte(i), bm.byteSet(i), bm.byte(i));
            //}
            
            var i:int;
            trace(bm.size);
            for( i= 0; i < bm.size;++i) {
                bm.bitSet(i);
            }
            trace(bm.snapshot());
            
            for( i= 0; i < bm.size;++i) {
                bm.bitClear(i);
            }
            trace(bm.snapshot());
            
            for( i= 0; i < bm.bytes.length;++i) {
                bm.byteSet(i);
            }
            trace(bm.snapshot());
            
            for( i= 0; i < bm.bytes.length;++i) {
                bm.byteClear(i);
            }
            trace(bm.snapshot());
            
            for( i= 0; i < bm.bytes.length;++i) {
                bm.byteSet(i);
            }
            
            bm.byteShift(2);
            
            
            trace(bm.snapshot());
        }
    }
}