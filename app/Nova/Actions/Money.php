<?php

namespace App\Nova\Actions;

use App\Enums\FromType;
use App\Models\User;
use App\Models\WalletType;
use App\Services\LogService;
use App\Services\UserWalletService;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Collection;
use Laravel\Nova\Actions\Action;
use Laravel\Nova\Fields\ActionFields;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;
use Lednerb\ActionButtonSelector\ShowAsButton;
use NormanHuth\NovaRadioField\Radio;

class Money extends Action
{
    use InteractsWithQueue, Queueable;
    use ShowAsButton;

    public $user;

    public function __construct(User $user = null)
    {
        $this->user = $user;
    }

    public function name()
    {
        return $this->name ?? __('Recharge');
    }

    /**
     * Perform the action on the given models.
     *
     * @param \Laravel\Nova\Fields\ActionFields $fields
     * @param \Illuminate\Support\Collection $models
     * @return mixed
     */
    public function handle(ActionFields $fields, Collection $models)
    {
        $logService = app()->make(LogService::class); // 钱包服务初始化
        $day = Carbon::now()->toDateString();

        foreach ($models as $model) {
            $id = $model->id;
            $type = $fields->type;
            $money = $fields->money;
            $remark = $fields->remark;
            // 给用户账户增加对应金额
            if (!$remark) {
                $remark = "后台管理员充值 " . $money;
            }
            $logService->userWalletLog($id, $type, $money, 0, $day, FromType::ADMIN, $remark);
        }

        return Action::message('账户已充值完毕!');
    }

    /**
     * Get the fields available on the action.
     *
     * @param \Laravel\Nova\Http\Requests\NovaRequest $request
     * @return array
     */
    public function fields(NovaRequest $request)
    {
        $user = (fn(): ?User => $request?->selectedResources()?->first())();

        $user = $user ?? $this->user;

        $list = WalletType::all();
        $options = [];
        if ($user) {
            $UserWalletService = app()->make(UserWalletService::class);
            $wallets = $UserWalletService->getUserWallets($user->id); // 获取用户账户各种积分余额
            foreach ($list as $key => $value) {
                $name = strtolower($value->slug);
                $balance = $wallets[$name . '_balance'];
                $options[$value->id] = $value->name . ' [ 当前: ' . $balance . ' ]';
            }
        } else {
            foreach ($list as $key => $value) {
                $name = strtolower($value->slug);
                $options[$value->id] = $value->name;
            }
        }

        return [
            Radio::make(__('WalletType'), 'type')->options($options)->gap(3)->inline()
                ->addClasses(['inline-flex flex-wrap gap-3'])
                ->help('请选择要操作的钱包类型')->required(),
            Number::make(__('Add'), 'money')->help('请输入金额,支持正数和负数')->required(),
            Text::make(__('Remark'), 'remark')->help('请输入调整理由'),
        ];
    }
}
