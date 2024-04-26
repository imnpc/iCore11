<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Outl1ne\NovaSettings\Models\Settings as SettingsModel;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class Settings extends SettingsModel
{
    use HasFactory;
    use LogsActivity;

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logAll()
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }
}
