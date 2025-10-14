use namespace HH\Lib\C;

class Solution {
    private vec<int> $nums;
    
    public function __construct(vec<int> $nums): void {
        $this->nums = $nums;
    }

    public function hasDuplicate(): bool {
        $map = dict<int, int>[];

        for ($i = 0; $i < C\count($this->nums); ++$i) {
            $n = $this->nums[$i];
            if (C\contains_key($map, $n)) {
                return true;
            } else {
                $map[$n] = 1;
            }
        }
        return false;
    }
}

<<__EntryPoint>>
function main(): void {
    $nums = vec<vec<int>>[
        vec<int>[1, 2, 3, 3],
        vec<int>[1,2,3,4],
        vec<int>[1,1,1,1]
    ];
    
    foreach($nums as $n) {
        $res = new Solution($n)->hasDuplicate();
        \var_dump($res);
    }
}
