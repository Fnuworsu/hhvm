enum RequestType: string {
    GET = "GET";
    PUT = "PUT";
    PATCH = "PATCH";
    UPDATE = "UPDATES",
    DELETE = "DELETES"
}

class Message {
    public RequestType $requestType;
    public string $topic;
    public dict<string, vec<int>> $content;
}

class Node {
    public ?string $userId;
    public ?Message $message;
    public ?int $serverId;
    public ?Node $next; 
    public ?Node $prev;


    public function __construct(?string $userId=null, ?Message $message=null, ?int $serverId=null, ?Node $next=null, ?Node $prev=null): void {
        $this->userId = $userId;
        $this->message = $message;
        $this->serverId = $serverId;
        $this->next = $next;
        $this->prev = $prev;
    }
}

class MessagingQueue {
    public Node $head;
    public Node $tail;

    public function __construct(Node $head, Node $tail): void {
        $this->head = new Node("x","x",-1);
        $this->tail = new Node("x","x",-1);

        $this->head->next = $this->tail;
        $this->tail->prev = $this->head;
    }

    public function add(Node $node): void {
        // head-> n1 -> tail
        $curr = $this->head;
        $curr->next->prev = $node;
        $node->next = $curr->next
        $curr->next = $node;
        $node->prev = $curr;
    }

    public function pop(): ?Node {
        $node = $this->tail->prev;

        $node->prev->next = $node->next;
        $node->next->prev = $node->prev;

        return $node;
    }
}