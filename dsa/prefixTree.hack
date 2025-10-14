use namespace HH\Lib\Str;
use namespace HH\Lib\C;

class TrieNode {
    public dict<string, ?TrieNode> $children;
    public bool $end;

    public function __construct(): void {
        $this->children = dict<string, ?TrieNode>[];
        $this->end = false;
    }
}

class Trie {
    public ?TrieNode $root;

    public function __construct(): void {
        $this->root = new TrieNode();
    }

    public function insert(string $word): void {
        $curr = $this->root;

        foreach(Str\chunk($word) as $c) {
            if (C\contains_key($curr->children, $c)) {
                $curr = $curr->children[$c];
            } else {
                $curr->children[$c] = new TrieNode();
                $curr = $curr->children[$c];
            }
        }

        $curr->end = true;
    }

    public function search(string $word): bool {
        $curr = $this->root;

        foreach(Str\chunk($word) as $c) {
            if (!C\contains_key($curr->children, $c)) {
                return false;
            }
            $curr  = $curr->children[$c];
        }

        return $curr->end;
    }

    public function startsWith(string $word): bool {
        $curr = $this->root;

        foreach(Str\chunk($word) as $c) {
            if (!C\contains_key($curr->children, $c)) {
                return false;
            }
            $curr  = $curr->children[$c];
        }

        return true;
    }
}

<<__EntryPoint>>
function main(): void {
    $trie = new Trie();
    $trie->insert("apple");
    \var_dump($trie->search("apple"));
    \var_dump($trie->search("app"));  
    \var_dump($trie->startsWith("app"));
    $trie->insert("app");
    \var_dump($trie->search("app"));  
}