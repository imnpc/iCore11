<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\File;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesAndPermissionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions(); // 重置角色和权限的缓存
        $models = $this->getModels(); // 获取所有 Nova 后台资源(要求资源名称和 Models 目录下模型名称一样)
        array_push($models, 'Role', 'Permission', 'Settings', 'Activity'); // 需要额外追加 'Role','Permission','Settings','Activity',
        $collection = collect($models);
        // 带有 TODO 的是需要修改或者操作
        $guard_name = 'admins'; // 看守器 默认使用的是 web TODO
        $super_admin_email = 'admin@admin.com'; // 超级管理员邮箱 TODO
        // 模型名称对应的中文翻译 需要额外在这里添加 -> resources/lang/zh_CN.json  TODO
        // 创建权限列表
        $collection->each(function ($item, $key) use ($guard_name) {
            $viewAny = Permission::getPermission(['name' => 'viewAny'.$item, 'guard_name' => $guard_name]);
            if (! $viewAny) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'viewAny'.$item, 'title' => __($item).'列表']);
            }

            $view = Permission::getPermission(['name' => 'view'.$item, 'guard_name' => $guard_name]);
            if (! $view) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'view'.$item, 'title' => '查看'.__($item)]);
            }

            $create = Permission::getPermission(['name' => 'create'.$item, 'guard_name' => $guard_name]);
            if (! $create) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'create'.$item, 'title' => '创建'.__($item)]);
            }

            $update = Permission::getPermission(['name' => 'update'.$item, 'guard_name' => $guard_name]);
            if (! $update) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'update'.$item, 'title' => '更新'.__($item)]);
            }

            $delete = Permission::getPermission(['name' => 'delete'.$item, 'guard_name' => $guard_name]);
            if (! $delete) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'delete'.$item, 'title' => '删除'.__($item)]);
            }

            $restore = Permission::getPermission(['name' => 'restore'.$item, 'guard_name' => $guard_name]);
            if (! $restore) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'restore'.$item, 'title' => '恢复'.__($item)]);
            }

            $forceDelete = Permission::getPermission(['name' => 'forceDelete'.$item, 'guard_name' => $guard_name]);
            if (! $forceDelete) {
                Permission::create(['guard_name' => $guard_name, 'group' => $item, 'name' => 'forceDelete'.$item, 'title' => '强制删除'.__($item)]);
            }
        });

        // 创建角色:超级管理员(super-admin)并分配所有权限
        $check_super = Role::findByParam(['guard_name' => $guard_name, 'name' => 'super-admin']);
        if (! $check_super) {
            $role = Role::create(['guard_name' => $guard_name, 'name' => 'super-admin', 'title' => '超级管理员']);
            $role->givePermissionTo(Permission::all());
        } else {
            $check_super->givePermissionTo(Permission::all());
        }

        // 授予指定用户超级管理员(super-admin)角色
        $user = \App\Models\AdminUser::whereEmail($super_admin_email)->first();
        $check_user = $user->hasRole('super-admin');
        if (! $check_user) {
            $user->assignRole('super-admin');
        }
    }

    /**
     * 获取所有 Nova 后台资源(要求资源名称和 Models 目录下模型名称一样)
     */
    public function getModels(): array
    {
        $path = app_path('Nova');
        $files = File::files($path);
        $filenames = array_map(function ($file): string {
            $pathinfo = pathinfo($file);

            return $pathinfo['filename'];
        }, $files);
        $mapped = array_map(
            function ($filename): ?string {
                $class = "{$filename}";

                if ($filename == 'Resource') {
                    return null;
                }

                return $class;
            },
            $filenames
        );
        $models = array_filter($mapped);

        return array_values($models);
    }
}
