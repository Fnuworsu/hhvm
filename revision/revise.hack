use namespace HH\Lib\Vec;

function path(int $a, (function(int, ?int): float) $f, ?int $b = null): float {
    return $f($a, $b ?? 0);
}

function calc(int $a, ?int $b = null): float {
    return ($a ** 2 + ($b ?? 0) ** 2) ** 0.5;
}

<<__EntryPoint>>
function main(): void {
    // $tuple = tuple(1, 2, 3);
    // list($x, $y, $z) = $tuple;
    // \var_dump($x, $y, $z);
    // $arr = vec[2,1,3]
    //     |> Vec\map($$, $x ==> $x ** 2)
    //     |> Vec\sort($$);
    // \var_dump(path(2, 3, ($a, $b) ==> ($a ** 2 + $b ** 2) ** 0.5));
    \var_dump(path(2, calc<>, 3));
    \var_dump(path(2, calc<>));
    exit(1);
}