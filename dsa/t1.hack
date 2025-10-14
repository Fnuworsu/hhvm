use namespace HH\Lib\Vec;

<<__EntryPoint>>
function main(): void {
    $nums = vec[1,2,3,4];
    $cache = keyset[1,2];
    \var_dump(array($nums));
    \var_dump(set($cache));
}

function array(vec<int> $nums): vec<int> {
    // append
    $nums[] = $nums[count($nums) - 1] + 1;
    $nums[] = 6;
    $nums[] = 7;
    
    // pop
    $nums = Vec\slice($nums, 0, count($nums) - 1);    
    return $nums;
}

function set(keyset<int> $cache): keyset<int> {
    // add
    $cache[] = 1;
    $cache[] = 1;
    $cache[] = 2;
    $cache[] = 3;
    // remove
    unset($cache[1]);
    return $cache;
}