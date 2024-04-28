<?php

use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Route::get('/user', function (Request $request) {
//    return $request->user();
//})->middleware('auth:sanctum');
Route::post('reg', [UserController::class, 'store']); // 注册
Route::post('login', [UserController::class, 'login']); // 登录
// 登录后可以访问的接口
Route::middleware('auth:sanctum')->group(function () {
    Route::get('me', [UserController::class, 'me']); // 当前登录用户信息
    Route::get('invite', [UserController::class, 'invite']); // 我的邀请码
    Route::get('team', [UserController::class, 'team']); // 我的推广记录
});
//Route::middleware('api')
//    ->group(function () {
//        // 游客可以访问的接口
////        Route::get('test', [IndexController::class, 'test']); // test
////        Route::get('setAgentLevels', [IndexController::class, 'setAgentLevels']); // 设置经销商等级（导入会员数据时使用
////        Route::get('index', [IndexController::class, 'index']); // APP 首页
////        Route::get('areaList', [AreaController::class, 'areaList']); // 全国省市区列表
////        Route::get('provinceList', [AreaController::class, 'provinceList']); // 全国省份列表
////        Route::get('cityList', [AreaController::class, 'cityList']); // 某省份包含的市列表
////        Route::get('districtList', [AreaController::class, 'districtList']); // 某市包含的区列表
////        Route::post('weixinCode', [UtilsController::class, 'weixinCode']); // 用户微信CODE换token
////        Route::post('jssdksign', [UtilsController::class, 'jsSdkSign']); // 生成 JSSDK 签名
////        Route::get('getSiteSetting', [UtilsController::class, 'getSiteSetting']); // 站点设置项
//
//        Route::any('reg', [UserController::class, 'store']); // 注册
//
////        Route::post('lastVersion', [VersionController::class, 'lastVersion']); // APP 最新版本信息
////        Route::post('checkVersion', [VersionController::class, 'checkVersion']); // 检测版本更新
//
//        // 登录后可以访问的接口
//        Route::middleware('auth:sanctum')->group(function () {
//            Route::get('user', [UserController::class, 'me']); // 当前登录用户信息
//            Route::post('getUserInfo', [UserController::class, 'getUserInfo']); // 获取某用户信息
//        });
//    });
