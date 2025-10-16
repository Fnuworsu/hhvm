use namespace HH\Lib\Str;
use namespace HH\Asio;

class Exchange {
    public int $numOfServers;
    public string $userId;
    public int $load = 0;

    public function __construct(int $numOfServers, string $userId): void {
        $this->numOfServers = $numOfServers;
        $this->userId = $userId;
    }

    async public function nextQueue(): Awaitable<int> {
        await self::simServerLoad();
        $hashValue = $c ==> ord($c) - ord("a") + 1;
        $hashKey = 0;

        foreach (Str\chunck($this->userId) as $c) {
            $hashKey += $hashValue($c);
        }

        return $this->numOfServers % $hashKey;
    }

    async public static function simServerLoad(): Awaitable<void> {
        $milli = 1000;
        $wait = 20;
        $waitTime = $wait * $milli;

        $this->load += $wait;
        Asio\usleep($waitTime);
    }
}

