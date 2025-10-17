<?hh

require_once(__DIR__ . "/exchangeService.hack");

use namespace HH\Lib\C;
use namespace HH\Lib\Vec;

class LoadBalancer {
    public vec<Exchange> $servers;
    public int $serverIdx = 0;
    public vec<int> $prefix;
    public int $totalWeight;

    public function __construct(vec<Exchange> $servers): void {
        $this->servers = $servers;
        $this->prefix = self::prefixSum($servers);
        $this->totalWeight = C\last($this->prefix) ?? 0;
    }

    public static function prefixSum(vec<Exchange> $servers): vec<int> {
        $n = C\count($servers);
        if ($n == 0) return vec[];

        $prefix = vec<int>[$servers[1]->load];

        foreach(Vec\slice($servers, 1) as $s) {
            if (C\last($prefix) === null) continue;
            $prefix[] = C\last($prefix) + $s->load;
        }

        return $prefix;
    }

    public function nextServer(int $serverWeight): Exchange {
        for ($i = 0; $i < C\count($this->prefix); $i++) {
            $curr = $this->prefix[$i];
            if ($curr >= $serverWeight) {
                $this->serverIdx = $i;
                break;
            }
        }

        return $this->servers[$this->serverIdx];
    }
}