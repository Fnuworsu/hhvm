class Node {
    public int $val;
    public ?Node $next;

    public function __construct(int $val): void {
        $this->val = $val;
        $this->next = null;
    }
}

class Solution {
    private ?Node $l1;
    private ?Node $l2;

    public function __construct(?Node $l1, ?Node $l2): void {
        $this->l1 = $l1;
        $this->l2 = $l2;
    }


    public function mergeTwoLists(): ?Node {
        return self::dfs($this->l1, $this->l2);
    }

    public static function dfs(?Node $l1, ?Node $l2): ?Node {
        if ($l1 === null) {
            return $l2;
        }

        if ($l2 === null) {
            return $l1;
        }

        if ($l1->val > $l2->val) {
            $temp = $l1;
            $l1 = $l2;
            $l2 = $temp;
        }

        $l1->next = self::dfs($l1->next, $l2);
        return $l1;
    }
}

<<__EntryPoint>>
function main (): void {
    // list1 = [1,2,4], list2 = [1,3,4]
    $l1 = new Node(1);
    $a = new Node(2);
    $b = new Node(4);

    // build l1
    $l1->next = $a;
    $a->next = $b;

    $l2 = new Node(1);
    $c = new Node(3);
    $d = new Node(4);

    // build l2
    $l2->next = $c;
    $c->next = $d;

    \var_dump(new Solution($l1, $l2)->mergeTwoLists());
}
