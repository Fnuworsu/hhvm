use namespace HH\Lib\Dict;
use namespace HH\Lib\C;

class Solution {
    private vec<int> $nums;
    private int $target;

    public function __construct(vec<int> $nums, int $target): void {
        $this->nums = $nums;
        $this->target = $target;
    }

    public function twoSum(): vec<int> {
        $arr = $this->nums;
        $res = $this->target;
        $hashMap = dict<int, int>[];

        foreach($arr as $i => $n) {
            $diff = $res - $n;

            if (C\contains_key($hashMap, $diff)) {
                return vec[$hashMap[$diff], $i];
            }
            $hashMap[$n] = $i;
        }
        return vec[-1,-1];
    }
}

<<__EntryPoint>>
function main(): void {
    $nums = dict<int, vec<int>>[
        7 => vec[3,4,5,6],
        10 => vec[4,5,6],
        11 => vec[5,5]
    ];

    foreach($nums as $target=>$arr) {
        \var_dump(new Solution($arr, $target)->twoSum());
    }
}