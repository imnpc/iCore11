<?php

use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Route::get('/user', function (Request $request) {
//    return $request->user();
//})->middleware('auth:sanctum');

Route::middleware('throttle:' . config('api.rate_limits.sign'))
    ->group(function () {
        Route::post('reg', [UserController::class, 'store']); // 注册
        Route::post('login', [UserController::class, 'login']); // 登录
        Route::get('test', [UserController::class, 'test']); // 测试
    });

Route::middleware('throttle:' . config('api.rate_limits.access'))
    ->group(function () {
        // 游客可以访问的接口
        // 登录后可以访问的接口
        Route::middleware('auth:sanctum')->group(function () {
            Route::get('me', [UserController::class, 'me']); // 当前登录用户信息
            Route::get('invite', [UserController::class, 'invite']); // 我的邀请码
            Route::get('team', [UserController::class, 'team']); // 我的推广记录
        });
    });
