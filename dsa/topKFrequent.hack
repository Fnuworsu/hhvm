use namespace HH\Lib\Dict;
use namespace HH\Lib\Vec;
use namespace HH\Lib\C;

class Solution {
    private vec<int> $nums;
    private int $k;

    public function __construct(vec<int> $nums, int $k): void {
        $this->nums = $nums;
        $this->k = $k;
    }

    public function topKFrequent(): vec<int> {
        $freq = Dict\count_values($this->nums);
        $bucket = vec<vec<int>>[];

        for ($i = 0; $i < C\count($this->nums) + 1; ++$i) {
            $bucket[] = vec<int>[];
        }

        foreach($freq as $key => $val) {
            $bucket[$val][] = $key;
        }

        $res = vec<int>[];

        foreach(Vec\reverse($bucket) as $buck) {
            foreach($buck as $b) {
                $res[] = $b;
                if (C\count($res) === $this->k) {
                    return $res;
                }
            }
        }
    }
}

<<__EntryPoint>>
function main(): void {
    $nums = vec<int>[1,2,2,3,3,3];
    $k = 2;

    \var_dump(new Solution($nums, $k)->topKFrequent());
}