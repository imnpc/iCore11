<?php

namespace App\Nova\Filters;

use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Cache;
use Laravel\Nova\Filters\DateFilter;
use Laravel\Nova\Http\Requests\NovaRequest;

class DateEnd extends DateFilter
{
    /**
     * Apply the filter to the given query.
     *
     * @param \Laravel\Nova\Http\Requests\NovaRequest $request
     * @param \Illuminate\Database\Eloquent\Builder $query
     * @param mixed $value
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function apply(NovaRequest $request, $query, $value)
    {
        $value = Carbon::parse($value);

        return $query;
    }

    /**
     * 过滤器的可显示名称。
     *
     * @var string
     */
    public $name = '结束日期';

    // set default date
    public function default()
    {
        $data = null;
        // 读取缓存的起始结束时间
        if (Cache::has('SearchDateStartEnd') && Cache::has('SearchFilter')) {
            $date_list = Cache::get('SearchDateStartEnd');
            $data = Carbon::parse($date_list['end'])->toDateString();
        }

        return $data;
    }
}
