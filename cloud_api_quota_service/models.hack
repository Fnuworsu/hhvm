<?hh // strict

class QuotaRequest {

    public function __construct(
        private AppId $app,
        private string $endpoint,
        private int $timestamp,
    ) {}

    public function getApp(): AppId {
        return $this->app;
    }

    public function getEndpoint(): string {
        return $this->endpoint;
    }

    public function getTimestamp(): int {
        return $this->timestamp;
    }
}

class QuotaResult {

    public function __construct(
        private bool $allowed,
        private int $remaining,
        private int $reset_at,
    ) {}

    public function isAllowed(): bool {
        return $this->allowed;
    }

    public function getRemaining(): int {
        return $this->remaining;
    }

    public function getResetAt(): int {
        return $this->reset_at;
    }
}