<?php

use App\Jobs\NovaLicenseKey;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

//Artisan::command('inspire', function () {
//    $this->comment(Inspiring::quote());
//})->purpose('Display an inspiring quote')->hourly();

Schedule::job(new NovaLicenseKey)->everyThirtyMinutes(); // 更新 Nova 授权缓存
