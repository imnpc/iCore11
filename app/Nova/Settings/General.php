<?php
namespace App\Nova\Settings;

use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\Date;

class General
{
    public string $name = "general";

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
