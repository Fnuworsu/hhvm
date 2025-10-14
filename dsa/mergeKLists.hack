use namespace HH\Lib\Vec;
use namespace HH\Lib\C;

class Node {
    public int $val;
    public ?Node $next;

    public function __construct(int $val): void {
        $this->val = $val;
        $this->next = null;
    }
}

class Solution {
    private vec<?Node> $lists;

    public function __construct(vec<?Node> $lists): void {
        $this->lists = $lists;
    }

    public function mergeKLists(): ?Node {
        if ($this->lists === null) {
            return null;
        }

        $pq = vec<?Node>[];

        foreach ($this->lists as $l) {
            if ($l === null) {continue;}
            $pq[] = $l;
        }

        $pq = Vec\sort_by($pq, $n ==> $n->val);
        $res = new Node(-1);
        $ptr = $res;

        while (!C\is_empty($pq)) {
            $node = C\pop_front(inout $pq);

            if ($node === null) {
                continue;
            }

            $ptr->next = $node;
            $ptr = $ptr->next;

            if ($node->next !== null) {
                $pq[] = $node->next;
                $pq = Vec\sort_by($pq, $n ==> $n->val);
            }
        }

        return $res->next;
    }
}

function buildNode(vec<int> $nums): ?Node {
    if ($nums === null) {
        return null;
    }

    $node = new Node(-1);
    $ptr = $node;

    foreach($nums as $n) {
        $ptr->next = new Node($n);
        $ptr = $ptr->next;
    }

    return $node->next;
}

<<__EntryPoint>>
function main():void {
    $input = vec<vec<int>>[
        vec<int>[1,4,5],
        vec<int>[1,3,4],
        vec<int>[2,6]
    ];

    $lists = vec<?Node>[];

    foreach($input as $list) {
        $lists[] = buildNode($list);
    }

    $res = new Solution($lists)->mergeKLists();
    \var_dump($res);
}