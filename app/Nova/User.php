<?php

namespace App\Nova;

use Illuminate\Http\Request;
use Illuminate\Validation\Rules;
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Fields\Password;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;
use Pavloniym\ActionButtons\ActionButton;
use Trin4ik\NovaSwitcher\NovaSwitcher;
use Wdelfuego\Nova\DateTime\Fields\DateTime;

class User extends Resource
{
    /**
     * The model the resource corresponds to.
     *
     * @var class-string<\App\Models\User>
     */
    public static $model = \App\Models\User::class;

    public static $perPageOptions = [50,100,200]; // 翻页项

    public static $perPageViaRelationship = 50;  // 关联单页显示数量

    /**
     * The single value that should be used to represent the resource when being displayed.
     *
     * @var string
     */
    public static $title = 'nickname';

    /**
     * The columns that should be searched.
     *
     * @var array
     */
    public static $search = [
        'id', 'name', 'email', 'mobile', 'nickname',
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
        return __('Users');
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

            Text::make(__('nickname'), 'nickname')->rules('required', 'max:255'),
            Text::make(__('mobile'), 'mobile')->rules('required', 'max:13'),
            Password::make(__('Password'), 'password')
                ->onlyOnForms()
                ->creationRules('required', Rules\Password::defaults())
                ->updateRules('nullable', Rules\Password::defaults()),
            BelongsTo::make(__('parent_id'), 'parent', 'App\Nova\User')->nullable()->withoutTrashed()->onlyOnIndex(),
            Number::make(__('parent_id'),'parent_id')->nullable()->filterable(),

            Boolean::make(__('status'),'status')->exceptOnForms(),
            NovaSwitcher::make(__('status'),'status')->onlyOnForms(),

            DateTime::make(__('created_at'),'created_at')->readonly(),
            DateTime::make(__('updated_at'),'updated_at')->hideFromIndex()->readonly(),

            // 用户树 UserTreeTo
            ActionButton::make(' ')
                ->text(' 查看树')
                ->styles(['display'=>'initial'])
                ->classes(['link-default'])
//                    ->icon('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
//  <path fill-rule="evenodd" d="M8.25 6.75a3.75 3.75 0 117.5 0 3.75 3.75 0 01-7.5 0zM15.75 9.75a3 3 0 116 0 3 3 0 01-6 0zM2.25 9.75a3 3 0 116 0 3 3 0 01-6 0zM6.31 15.117A6.745 6.745 0 0112 12a6.745 6.745 0 016.709 7.498.75.75 0 01-.372.568A12.696 12.696 0 0112 21.75c-2.305 0-4.47-.612-6.337-1.684a.75.75 0 01-.372-.568 6.787 6.787 0 011.019-4.38z" clip-rule="evenodd" />
//  <path d="M5.082 14.254a8.287 8.287 0 00-1.308 5.135 9.687 9.687 0 01-1.764-.44l-.115-.04a.563.563 0 01-.373-.487l-.01-.121a3.75 3.75 0 013.57-4.047zM20.226 19.389a8.287 8.287 0 00-1.308-5.135 3.75 3.75 0 013.57 4.047l-.01.121a.563.563 0 01-.373.486l-.115.04c-.567.2-1.156.349-1.764.441z" />
//</svg>
//') // Svg icon (optional)
                ->action((new Actions\Url\UserTreeTo($this->resource))->withoutConfirmation()->standalone(), $this->resource->id)
                ->asToolbarButton(),// Display as row toolbar button (optional)

            \Konsulting\NovaTarget\NovaTarget::make('')->hideUpdateAndContinueEditingButton(), // 屏蔽多余按钮
            \Konsulting\NovaTarget\NovaTarget::make('')->hideCreateAndAddAnotherButton(), // 屏蔽多余按钮
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
        return [
            (new Actions\Url\UserTreeTo)->onlyOnDetail(),
        ];
    }
    /**
     * Get the displayble label of the resource.
     *
     * @return string
     */
    public static function label()
    {
        return __('Users');
    }

    /**
     * Get the displayble singular label of the resource.
     *
     * @return string
     */
    public static function singularLabel()
    {
        return __('Users');
    }

    /**
     * Get the value that should be displayed to represent the resource.
     *
     * @return string
     */
    public function title()
    {
        return $this->nickname;
    }

    /**
     * Get the search result subtitle for the resource.
     *
     * @return string
     */
    public function subtitle()
    {
        return $this->nickname . '/' . $this->mobile;
    }

    // 是否允许查看
    public function authorizedToView(Request $request): bool
    {
        return false;
    }
}
