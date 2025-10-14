use namespace HH\Lib\Vec;
use namespace HH\Lib\Str;
use namespace HH\Lib\C;

class Solution {
    private vec<string> $strs;

    public function __construct(vec<string> $strs): void {
        $this->strs = $strs;
    }

    public function groupAnagrams(): vec<vec<string>> {
        $arr = $this->strs;
        $idx = $c ==> ord($c) - ord("a");
        $map = dict<string, vec<string>>[];

        foreach ($arr as $s) {
            $key = Vec\fill(26, 0);

            foreach(Str\chunk($s) as $c) {
                $key[$idx($c)]++;
            }

            $k = Str\join($key, "#");
            if (C\contains_key($map, $k)) {$map[$k][] = $s;}
            else {$map[$k] = vec<string>[$s];}
        }

        $res = vec[];

        foreach($map as $k => $v) {
            $res[] = $v;
        }

        return $res;
    }
}

<<__EntryPoint>>
function main(): void {
    $strs = vec["act","pots","tops","cat","stop","hat"]; 
    \var_dump(new Solution($strs)->groupAnagrams());
}