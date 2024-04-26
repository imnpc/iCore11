<?php
namespace App\Nova\Settings;

use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\Date;

class Site
{
    public string $name = "site";

    public function fields(): array
    {
        return [
            Text::make(__('SiteName'),'site_name'),
            Text::make(__('SiteUrl'),"site_url"),
            Boolean::make(__('IsEnable'),"is_enable"),
        ];
    }

    public function casts(): array
    {
        return [

        ];
    }
}
