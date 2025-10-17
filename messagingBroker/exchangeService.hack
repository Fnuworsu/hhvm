<?hh

use namespace HH\Lib\Str;
use namespace HH\Asio;

class Exchange {
    public int $numOfServers;
    public string $userId;
    public int $load = 0;

    public function __construct(
        int $numOfServers, 
        string $userId
    ): void {
        $this->numOfServers = $numOfServers;
        $this->userId = $userId;
    }

    async public function nextQueue(): Awaitable<int> {
        await self::simServerLoad($this);
        $hashValue = $c ==> ord($c) - ord("a") + 1;
        $hashKey = 0;

        foreach (Str\chunk($this->userId) as $c) {
            $hashKey += $hashValue($c);
        }

        return $hashKey % $this->numOfServers;
    }

    async public static function simServerLoad(Exchange $instance): Awaitable<void> {
        $milli = 1000;
        $wait = 20;
        $waitTime = $wait * $milli;

        $instance->load += $wait;
        Asio\usleep($waitTime);
    }
}

