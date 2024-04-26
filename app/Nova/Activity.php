<?php

namespace App\Nova;

use Bolechen\NovaActivitylog\Resources\Activitylog;
use Illuminate\Http\Request;
use Laravel\Nova\Fields\Badge;
use Laravel\Nova\Fields\Code;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\MorphTo;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;
use Wdelfuego\Nova\DateTime\Fields\DateTime;

class Activity extends Activitylog
{
    /**
     * Get the fields displayed by the resource.
     *
     * @return array
     */
    public function fields(NovaRequest $request)
    {
        return [
            ID::make()->sortable(),

            //            Text::make(__('Description'), 'description'),
            Badge::make('操作类型', 'description')->map([
                'created' => 'info',
                'updated' => 'success',
                'deleted' => 'danger',
            ])->labels([
                'created' => '创建',
                'updated' => '更新',
                'deleted' => '删除',
            ]),
            Text::make(__('Subject Id'), 'subject_id')->filterable(),
            Text::make(__('Subject Type'), 'subject_type')->filterable(),
            MorphTo::make(__('Causer'), 'causer'),
            Text::make(__('Causer Ip'), 'properties->ip')->onlyOnIndex(),

            Code::make(__('Properties'), 'properties')->json(JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE),
            DateTime::make(__('Created At'), 'created_at')->readonly()->filterable(),

            \Konsulting\NovaTarget\NovaTarget::make('')->hideUpdateAndContinueEditingButton(), // 屏蔽多余按钮
            \Konsulting\NovaTarget\NovaTarget::make('')->hideCreateAndAddAnotherButton(), // 屏蔽多余按钮
        ];
    }

    /**
     * Get the cards available for the request.
     *
     * @return array
     */
    public function cards(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the filters available for the resource.
     *
     * @return array
     */
    public function filters(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the lenses available for the resource.
     *
     * @return array
     */
    public function lenses(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the actions available for the resource.
     *
     * @return array
     */
    public function actions(NovaRequest $request)
    {
        return [];
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
        return true;
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

    // 是否允许复制
    public function authorizedToReplicate(Request $request): bool
    {
        return false;
    }

    // 是否允许搜索
    public static function searchable()
    {
        return false;
    }
}
