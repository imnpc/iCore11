<?php

namespace App\Nova;

use App\Enums\FromType;
use App\Nova\Filters\UserWalletLogAdd;
use Illuminate\Http\Request;
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\Date;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Fields\Select;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

class UserWalletLog extends Resource
{
    /**
     * The model the resource corresponds to.
     *
     * @var class-string<\App\Models\UserWalletLog>
     */
    public static $model = \App\Models\UserWalletLog::class;

    public static $perPageOptions = [50,100,200]; // 翻页项

    public static $perPageViaRelationship = 50;  // 关联单页显示数量

    /**
     * The single value that should be used to represent the resource when being displayed.
     *
     * @var string
     */
    public static $title = 'id';

    /**
     * The columns that should be searched.
     *
     * @var array
     */
    public static $search = [
        'user_id', 'wallet_type_id', 'order_id', 'from_user_id', 'day', 'add', 'from', 'remark',
    ];

    /**
     * Whether to show borders for each column on the X-axis.
     *
     * @var bool
     */
    public static $showColumnBorders = false;

    /**
     * The visual style used for the table. Available options are 'tight' and 'default'.
     *
     * @var string
     */
    public static $tableStyle = 'default';

    /**
     * The logical group associated with the resource.
     *
     * @var string
     */
    public static function group()
    {
        return __('Pay');
    }

    /**
     * Custom priority level of the resource.
     *
     * @var int
     */
    public static $priority = 2;

    /**
     * Get the fields displayed by the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function fields(NovaRequest $request)
    {
        return [
            ID::make()->sortable(),
            BelongsTo::make(__('Users'), 'user', 'App\Nova\User')->filterable(),
            BelongsTo::make(__('WalletType'), 'walletType', 'App\Nova\WalletType')->filterable(),
            Date::make(__('Day'),'day')->filterable(),
            Number::make(__('Old'),'old'),
            Number::make(__('Add'),'add')->filterable(),
            Number::make(__('NewNum'),'new'),
            Select::make(__('FromType'),'from')->options(FromType::asSelectArray())->displayUsingLabels()->filterable(),
            BelongsTo::make(__('FromUser'), 'fromUser', 'App\Nova\User'),
            Text::make(__('Remark'),'remark'),
        ];
    }

//            $table->string('remark')->nullable()->comment('备注');
    /**
     * Get the cards available for the request.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function cards(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the filters available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function filters(NovaRequest $request)
    {
        return [
            UserWalletLogAdd::make(),
        ];
    }

    /**
     * Get the lenses available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function lenses(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the actions available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function actions(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the displayble label of the resource.
     *
     * @return string
     */
    public static function label()
    {
        return __('UserWalletLog');
    }

    /**
     * Get the displayble singular label of the resource.
     *
     * @return string
     */
    public static function singularLabel()
    {
        return __('UserWalletLog');
    }

    // 屏蔽权限
    // 是否允许创建
    public static function authorizedToCreate(Request $request): bool
    {
        return false;
    }

    // 是否允许查看
    public function authorizedToView(Request $request): bool
    {
        return false;
    }

    // 是否允许编辑
    public function authorizedToUpdate(Request $request): bool
    {
        return false;
    }

    // 是否允许删除
    public function authorizedToDelete(Request $request): bool
    {
        return false;
    }

    // 是否允许搜索
    public static function searchable()
    {
        return true;
    }

    // 是否允许选择显示已删除的资源
    public static function softDeletes()
    {
        return false;
    }
}
