<?php

namespace App\Nova;

use Illuminate\Http\Request;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

class WalletType extends Resource
{
    /**
     * The model the resource corresponds to.
     *
     * @var class-string<\App\Models\WalletType>
     */
    public static $model = \App\Models\WalletType::class;

    /**
     * The single value that should be used to represent the resource when being displayed.
     *
     * @var string
     */
    public static $title = 'name';

    /**
     * The columns that should be searched.
     *
     * @var array
     */
    public static $search = [
        'id','name','slug'
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
    public static $tableStyle = 'tight';

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
    public static $priority = 1;

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
            Text::make(__('Name'), 'name')
                ->rules('required', 'max:255'),
            Text::make(__('Slug'), 'slug')
                ->help('大写英文字母')
                ->rules('required', 'max:255')->readonly(function ($request) {
                    return $request->isUpdateOrUpdateAttachedRequest();
                }),

            Text::make(__('Description'), 'description'),
            Number::make(__('DecimalPlaces'), 'decimal_places')->default(2)->help('小数位数,创建以后不建议更改')->required(),
            Image::make(__('Icon'),'icon'),
            Boolean::make(__('IsEnabled'),'is_enabled'),
            \Konsulting\NovaTarget\NovaTarget::make('')
                ->hideUpdateAndContinueEditingButton(),
        ];
    }

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
        return [];
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
        return __('WalletType');
    }

    /**
     * Get the displayble singular label of the resource.
     *
     * @return string
     */
    public static function singularLabel()
    {
        return __('WalletType');
    }

   // 禁止查看
    public  function authorizedToView(Request $request): bool
    {
        return false;
    }

    // 禁止删除
    public  function authorizedToDelete(Request $request): bool
    {
        return false;
    }
}
