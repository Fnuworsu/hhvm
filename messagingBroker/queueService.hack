<?hh

enum RequestType: string {
    GET = "GET";
    PUT = "PUT";
    PATCH = "PATCH";
    UPDATE = "UPDATES";
    DELETE = "DELETES";
}

class Message {
    public RequestType $requestType;
    public string $topic;
    public dict<string, vec<int>> $content;

    public function __construct(
        RequestType $requestType,
        string $topic,
        dict<string, vec<int>> $content
    ): void {
        $this->requestType = $requestType;
        $this->topic = $topic;
        $this->content = $content;
    }
}

class Node {
    public ?string $userId;
    public ?Message $message;
    public ?int $serverId;
    public ?Node $next; 
    public ?Node $prev;


    public function __construct(
        ?string $userId=null,
        ?Message $message=null,
        ?int $serverId=null,
        ?Node $next=null,
        ?Node $prev=null
    ): void {
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

    public function __construct(): void {
        $this->head = new Node("head",null,-1);
        $this->tail = new Node("tail",null,-1);

        $this->head->next = $this->tail;
        $this->tail->prev = $this->head;
    }

    public function add(Node $node): void {
        // head-> n1 -> tail
        $curr = $this->head;
        $nextNode = $curr->next;
        
        if ($nextNode !== null) {
            $nextNode->prev = $node;
        }

        $node->next = $nextNode;
        $curr->next = $node;
        $node->prev = $curr;
    }

    public function pop(): ?Node {
        $node = $this->tail->prev;
        if ($node === $this->head) {
            return null;
        }
        
        $prevNode = $node->prev;
        $nextNode = $node->next;
        
        if ($prevNode !== null) {
            $prevNode->next = $nextNode;
        }
        if ($nextNode !== null) {
            $nextNode->prev = $prevNode;
        }

        return $node;
    }

    public function isEmpty(): bool {
        return $this->head->next === $this->tail;
    }
}