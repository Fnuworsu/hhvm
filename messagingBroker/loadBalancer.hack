use namespace HH\Lib\C;
use namespace HH\Lib\Vec;

class LoadBalancer {
    public vec<Exchange> $servers;
    public int $serverIdx = 0;
    public vec<int> $prefix;

    public function __construct(vec<Exchange> $servers): void {
        $this->prefix = self::prefixSum($servers);
        $this->totalWeight = C\last($this->prefix);
        $this->servers = $servers;
    }

    public static function prefixSum(vec<Exchange> $servers): vec<int> {
        $n = C\count($servers);
        $prefix = vec<int>[$servers[1]];

        foreach(Vec\($servers, 1, n) as $s) {
            $prefix[] = C\last($prefix) + $s;
        }

        return $prefix;
    }

    public function nextServer(int $serverWeight): Exchange {
        for ($i = 0; $i < C\count($this->prefix); $i++) {
            $curr = $this->prefix[$i];
            if ($curr < $serverWeight) {
                $this->serverIdx = $i;
                break;
            }
        }

        return $this->servers[$serverIdx];
    }
}