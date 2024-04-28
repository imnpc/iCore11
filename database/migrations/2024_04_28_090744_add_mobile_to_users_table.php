<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('mobile')->nullable()->unique()->comment('手机号码');
            $table->string('nickname')->nullable()->comment('昵称');
            $table->integer('parent_id')->nullable()->default('0')->comment('上级 ID');
            $table->integer('status')->default('1')->comment('状态'); //  0-禁用 1-启用
            $table->timestamp('last_login_at')->nullable()->comment('最后登录时间');
            $table->ipAddress('last_login_ip')->nullable()->comment('最后登录IP');
            $table->string('email')->nullable()->change();
            $table->string('name')->nullable()->comment('名称')->change();
            $table->comment('用户');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            //
        });
    }
};
