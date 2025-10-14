use namespace HH\Lib\Vec;
use namespace HH\Lib\Str;

class Solution {
    private string $s1;
    private string $s2;

    public function __construct(string $s1, string $s2): void {
        $this->s1 = $s1;
        $this->s2 = $s2;
    }

    public function isAnagram(): bool {
        if (Str\length($this->s1) !== Str\length($this->s2)) {
            return false;
        }

        $freq = Vec\fill(26, 0);
        $idx = $c ==> ord($c) - ord("a");

        foreach(Vec\zip(Str\chunk($this->s1), Str\chunk($this->s2)) as list($c1, $c2)) {
            $freq[$idx($c1)]++;
            $freq[$idx($c2)]--;
        }

        foreach($freq as $f) {
            if ($f !== 0) {
                return false;
            }
        }
        return true;
    }
}

<<__EntryPoint>>
function main(): void {
    $s = vec<vec<string>>[
        vec<string>["racecar", "carrace"],
        vec<string>["jar", "jam"]
    ];

    foreach($s as $arr) {
        list($s1, $s2) = $arr;
        \var_dump(new Solution($s1, $s2)->isAnagram());
    }
}
/**
 * counter => count_values(map, key)
 * del = drop(map, key)
 */