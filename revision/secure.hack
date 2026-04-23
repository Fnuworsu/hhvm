<<?hh

namespace Vault {

    abstract class BaseAccount {
        abstract const type TID as arraykey;

        public function __construct(
            protected int $balance,
            protected this::TID $accountID
        ) {}

        public function getBalance(): int {
            return $this->balance;
        }
    }

    <<__Sealed(PremiumSavings::class)>>
    class SavingsAccount extends BaseAccount {
        const type TID = int;

        <<__Override>>
        public function __construct(
            int $balance,
            int $id,
            private float $bonusRate
        ) {
            parent::__construct($balance, $id);
        }

        public static function calculateInterest(int $val): int {
            return (int)($val * 1.05);
        }
    }

    final class PremiumSavings extends SavingsAccount {}

    class VaultSession implements \IDisposable {
        public function __construct() {
            echo "Connection Opened\n";
        }

        public function applyInterest(inout int $bal): void {
            $bal = SavingsAccount::calculateInterest($bal);
        }

        public function __dispose(): void {
            echo "Connection Closed safely.\n";
        }
    }
}