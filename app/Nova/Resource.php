<?php

namespace App\Nova;

use Illuminate\Http\Request;
use Laravel\Nova\Http\Requests\NovaRequest;
use Laravel\Nova\Resource as NovaResource;
use Laravel\Nova\URL;

abstract class Resource extends NovaResource
{
    /**
     * Build an "index" query for the given resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public static function indexQuery(NovaRequest $request, $query)
    {
        return $query;
    }

    /**
     * Build a Scout search query for the given resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @param  \Laravel\Scout\Builder  $query
     * @return \Laravel\Scout\Builder
     */
    public static function scoutQuery(NovaRequest $request, $query)
    {
        return $query;
    }

    /**
     * Build a "detail" query for the given resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public static function detailQuery(NovaRequest $request, $query)
    {
        return parent::detailQuery($request, $query);
    }

    /**
     * Build a "relatable" query for the given resource.
     *
     * This query determines which instances of the model may be attached to other resources.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public static function relatableQuery(NovaRequest $request, $query)
    {
        return parent::relatableQuery($request, $query);
    }

    /**
     * 默认创建资源以后 跳转到资源列表
     * Return the location to redirect the user after creation.
     *
     * @param NovaRequest $request
     * @param NovaResource $resource
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
     * @param NovaRequest $request
     * @param NovaResource $resource
     * @return URL|string
     */
    public static function redirectAfterUpdate(NovaRequest $request, $resource): URL|string
    {
        return '/resources/'.static::uriKey();
    }

    /**
     * 禁止 复制
     * @param Request $request
     * @return bool
     */
    public function authorizedToReplicate(Request $request): bool
    {
        return false;
    }

    // 禁止 删除
    public function authorizedToDelete(Request $request): bool
    {
        return false;
    }

    // 禁止 强制删除
    public function authorizedToForceDelete(Request $request): bool
    {
        return false;
    }
}
