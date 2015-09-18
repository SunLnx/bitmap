package
{
    import flash.utils.ByteArray;

    public class BitMap {

        // 在p2p模块中，bitmap主要表示向向其他
        public static const HEADER_SIZE:int = 8;
        
        private static const SETS:Array = [128, 64, 32, 16, 8, 4, 2, 1];
        private static const CLEARS:Array = [127, 191, 223, 239, 247, 251, 253, 254];
        
        private var _size:int;
        private var _bytes:ByteArray;
        
        public function BitMap(size:int){
            _size = size;
            _bytes = new ByteArray;
            _bytes.length = int ((size + 7) >> 3);
        }
        
        /**
         * 置第index个bit位为1
         * @param	index
         */
        public function bitSet(index:int):void {
            if (index < _size && index >= 0) {
                var byte:int = index >> 3;
                var bit:int = index - (byte << 3);
                _bytes[byte] |= SETS[bit];
            }
        }
        
        /**
         * 置第index个bit位为0
         * @param	index
         */
        public function bitClear(index:int):void {
            if (index < _size && index >= 0) {
                var byte:int = index >>3;
                var bit:int = index - (byte<<3);
                _bytes[byte] &= CLEARS[bit];
            }
        }
        
        
        /**
         * 获取第index个bit位状态
         * @param	index
         * @return
         */
        public function bit(index:int):Boolean {
            if (index <_size && index  >= 0) {
                var byte:int = index >>3;
                var bit:int = index - (byte <<3);
                return (_bytes[byte] & SETS[bit]) > 0;
            }
            return false;
        }

        
        /**
         * 置第index个byte位为00000000
         * @param	index
         */
        public function bitsClear(index:int):void {
            if (index < _bytes.length) {
                _bytes[index] = 0;
            }
        }
        
        /**
         * 获取第index个byte位状态：11111111表示true，其他全为false
         * @param	index
         * @return
         */
        public function byte(index:int):Boolean {
            if (index < _bytes.length) {
                return _bytes[index] == 255;
            }
            return false;
        }
        
        /**
         * 向左移动length bit
         * @param	length
         */
        public function bitShift(step:int):void {
			if (step <= 0) {
				return;
			}
			if (step >= _size) {
				_bytes.clear();
				_bytes.length = int ((_size + 7) >> 3);
			} else {
				var bit:int = step % 8;
				var bytes:int  = step >> 3;
				if (bit == 0) {
					for (var i:int = bytes ; i < _bytes.length; ++i) {
						_bytes[i - bytes] = _bytes[i];
					}
					for (var j:int = i - bytes; j < _bytes.length;++j) {
						_bytes[j] = 0;
					}
				} else {
					var rbit:int = 8 - bit;
					for (var k:int = bytes; k < _bytes.length -1; ++k) {
						_bytes[k - bytes] =  (_bytes[k] << bit) + (_bytes[k+1] >> rbit);  
					}
					_bytes[k ] = (_bytes[k] << bit);
				}
			}
        }
		
		/**
		 * private static const SETS:Array = [128, 64, 32, 16, 8, 4, 2, 1];
        private static const CLEARS:Array = [127, 191, 223, 239, 247, 251, 253, 254];
		 */
        
        public function get size():int
        {
            
            return _size;
        }

        public function set size(value:int):void
        {
            _size = value;
        }

        public function get bytes():ByteArray
        {
            return _bytes;
        }

        public function set bytes(value:ByteArray):void
        {
            _bytes = value;
        }
        
        /**
         * bitmap快照
         * @return
         */
        public function snapshot():String {
            var snapShot:String="";
            var j:int;
            var t:int;
            for (var i :int = 0; i < _bytes.length; ++i){
                for (j = 0; j < 8; ++j ){
                    if (t < _size  && (_bytes[i] & BitMap.SETS[j]) > 0) {
                        snapShot += "1";
                    } else if (t < _size) {
                        snapShot += "0";
                    }
                    t++;
                }
                snapShot += " ";
            }
            return snapShot;
        }
    }
}