<?php

namespace App\Nova\Dashboards;

use App\Nova\Metrics\TotalUsers;
use App\Nova\Metrics\UsersPerDay;
use Laravel\Nova\Cards\Help;
use Laravel\Nova\Dashboards\Main as Dashboard;

class Main extends Dashboard
{
    /**
     * Get the cards for the dashboard.
     *
     * @return array
     */
    public function cards()
    {
        return [
            (new TotalUsers)->icon('user-group')->width('1/2'),
            (new UsersPerDay)->width('1/2'),
//            new Help,
        ];
    }

    /**
     * Get the URI key for the dashboard.
     *
     * @return string
     */
    public function uriKey()
    {
        return 'main';
    }

    public function label()
    {
        return __('Main');
    }

    public function singularLabel()
    {
        return __('Main');
    }
}
