<?php

namespace App\Providers;

use App\Nova\Permission;
use App\Nova\Role;
use Eminiarts\Tabs\Tab;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\Gate;
use Laravel\Nova\Menu\Menu;
use Laravel\Nova\Menu\MenuGroup;
use Laravel\Nova\Nova;
use Laravel\Nova\NovaApplicationServiceProvider;

class NovaServiceProvider extends NovaApplicationServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();
        Nova::withBreadcrumbs(); // 显示导航
        //        Nova::initialPath('/resources/users'); // 默认控制台跳转
        // 自定义版权
        Nova::footer(function ($request) {
            return Blade::render('
            @env(\'local\')

            @endenv
            ');
        });

        // 标签页 中文切换
        Tab::createSlugUsing(fn(Tab $tab) => $tab->getTitle());

        // 网站配置项
        $settings = [
            new \App\Nova\Settings\General(), // 常规设置
            new \App\Nova\Settings\Site(), // 站点设置
        ];
        foreach ($settings as $setting) {
            Nova::serving(function () use ($setting) {
                \Outl1ne\NovaSettings\NovaSettings::addSettingsFields(
                    $setting->fields() ?? [],
                    $setting->casts() ?? [],
                    $setting->name ?? null
                );
            });
        }

        // 导航 group 排序 TODO
        $order = array_flip([
            trans('Users'),
            trans('Pay'),
            trans('Other'),
            trans('Admin'),
            'Other',
            'Settings',
        ]); // group 分组顺序,这里调用语言包地址 resources/lang/zh_CN.json
        Nova::mainMenu(static function (Request $request, Menu $menu) use ($order): Menu {
            $resources = $menu->items->firstWhere('name', __('Resources')); // 获取 「资源」下属 菜单列表,注意会根据 NOVA 框架语言包自动变换
            $resources->items = $resources->items->sort(
                fn (MenuGroup $a, MenuGroup $b): int => ($order[$a->name] ?? INF) <=> ($order[$b->name] ?? INF)
            );

            return $menu;
        });
    }

    /**
     * Register the Nova routes.
     *
     * @return void
     */
    protected function routes()
    {
        Nova::routes()
            ->withAuthenticationRoutes()
            ->withPasswordResetRoutes()
            ->register();
    }

    /**
     * Register the Nova gate.
     *
     * This gate determines who can access Nova in non-local environments.
     *
     * @return void
     */
    protected function gate()
    {
        Gate::define('viewNova', function ($user) {
            return $user->hasRole('super-admin') || $user->hasRole('admin') || $user->hasRole('user');
        });
        //        Gate::define('viewNova', function ($user) {
        //            return in_array($user->email, [
        //                //
        //            ]);
        //        });
    }

    /**
     * Get the dashboards that should be listed in the Nova sidebar.
     *
     * @return array
     */
    protected function dashboards()
    {
        return [
            new \App\Nova\Dashboards\Main,
        ];
    }

    /**
     * Get the tools that should be listed in the Nova sidebar.
     *
     * @return array
     */
    public function tools()
    {
        return [
            new \Outl1ne\NovaSettings\NovaSettings(), // 网站设置
            \Sereny\NovaPermissions\NovaPermissions::make()
                ->roleResource(Role::class)
                ->permissionResource(Permission::class), // 角色和权限(自定义)
        ];
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        Nova::sortResourcesBy(function ($resource) {
            return $resource::$priority ?? 99999;
        });
    }
}
