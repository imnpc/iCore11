<?php

namespace App\Nova;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\MorphToMany;
use Laravel\Nova\Fields\Select;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;
use Laravel\Nova\Resource as NovaResource;
use Laravel\Nova\URL;
use Sereny\NovaPermissions\Fields\Checkboxes;
use Sereny\NovaPermissions\Nova\Role as RoleResource;

class Role extends RoleResource
{
    public static $perPageOptions = [50, 100, 200]; // 翻页项

    public static $perPageViaRelationship = 50;  // 关联单页显示数量

    public static $displayInNavigation = false; // 是否在左侧菜单显示

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
        'id', 'name', 'title', 'guard_name',
    ];

    /**
     * Get the fields displayed by the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function fields(Request $request)
    {
        $guardOptions = $this->guardOptions($request);
        $userResource = $this->userResource();

        return [
            ID::make(__('ID'), 'id')
                ->rules('required')
                ->canSee(function ($request) {
                    return $this->fieldAvailable('id');
                }),

            Text::make(__('CodeName'), 'name')
                ->rules(['required', 'string', 'max:255'])
                ->creationRules('unique:'.config('permission.table_names.roles'))
                ->updateRules('unique:'.config('permission.table_names.roles').',name,{{resourceId}}')
                ->readonly(function ($request) {
                    return $request->isUpdateOrUpdateAttachedRequest();
                })
                ->help('本项尽量不要编辑,角色标识，如：user-manager'),

            Text::make(__('title'), 'title')
                ->rules(['required', 'string', 'max:255']),

            Select::make(__('Guard Name'), 'guard_name')
                ->options($guardOptions->toArray())
                ->rules(['required', Rule::in($guardOptions)])
                ->canSee(function ($request) {
                    return $this->fieldAvailable('guard_name');
                })
                ->default($this->defaultGuard($guardOptions)),

            Checkboxes::make(__('Permissions'), 'permissions')
                ->options($this->loadPermissions()->map(function ($permission, $key) {
                    return [
                        'group' => __(ucfirst($permission->group)),
                        'option' => $permission->name,
                        'label' => $permission->title,
                    ];
                })
                    ->groupBy('group')
                    ->toArray()),

            Text::make(__('Users'), function () {
                return $this->users()->count();
            })->exceptOnForms(),

            MorphToMany::make($userResource::label(), 'users', $userResource)
                ->searchable()
                ->canSee(function ($request) {
                    return $this->fieldAvailable('users');
                }),

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

    /**
     * 默认创建资源以后 跳转到资源列表
     * Return the location to redirect the user after creation.
     *
     * @param  NovaResource  $resource
     * @return URL|string
     */
    public static function redirectAfterCreate(NovaRequest $request, $resource)
    {
        return '/resources/'.static::uriKey();
    }

    /**
     * 默认更新资源以后 跳转到资源列表
     * Return the location to redirect the user after update.
     *
     * @param  NovaResource  $resource
     */
    public static function redirectAfterUpdate(NovaRequest $request, $resource): URL|string
    {
        return '/resources/'.static::uriKey();
    }

    // 是否允许复制
    public function authorizedToReplicate(Request $request): bool
    {
        return false;
    }

    // 是否允许删除
    public function authorizedToDelete(Request $request): bool
    {
        return false;
    }
}
