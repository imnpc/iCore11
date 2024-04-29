<?php declare(strict_types=1);

namespace App\Enums;

use BenSampo\Enum\Enum;

final class WalletAllType extends Enum
{
    // 钱包所有类型 1-余额 2-积分
    const MONEY = 1;
    const CREDIT = 2;

    public static function parseDatabase($value): int
    {
        return (int)$value;
    }

    public static function getDescription($value): string
    {
        return match ($value) {
            self::MONEY => '余额',
            self::CREDIT => '积分',
            default => self::getKey($value),
        };
    }
}
