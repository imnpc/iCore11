<?php declare(strict_types=1);

namespace App\Enums;

use BenSampo\Enum\Enum;

final class FromType extends Enum
{
    // 积分来源
    // 核心操作项
    const ADMIN = -1; // 后台
    const DEFAULT = 0; // 默认
    const ORDER = 1; // 订单
    const RECHARGE = 2; // 充值
    const WITHDRAW = 3; // 提现
    // 其他杂项
    const INVITE = 51; // 邀请
    const REGISTER = 52; // 注册
    const SIGN = 53; // 签到

    public static function parseDatabase($value): int
    {
        return (int)$value;
    }

    public static function getDescription($value): string
    {
        return match ($value) {
            self::DEFAULT => '默认',
            self::ADMIN => '后台',
            self::ORDER => '订单',
            self::RECHARGE => '充值',
            self::WITHDRAW => '提现',
            self::INVITE => '邀请',
            self::SIGN => '签到',
            self::REGISTER => '注册',
            default => self::getKey($value),
        };
    }
}
