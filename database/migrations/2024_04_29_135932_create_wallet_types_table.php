<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('wallet_types', function (Blueprint $table) {
            $table->id();
            $table->string('name')->comment('名称');
            $table->string('slug')->unique()->comment('大写英文代码');
            $table->string('description')->nullable()->comment('说明');
            $table->integer('decimal_places')->default(2)->comment('小数位数');
            $table->string('icon')->nullable()->comment('图标');
            $table->integer('sort')->default(0)->comment('排序');
            $table->integer('is_enabled')->default(0)->comment('是否启用'); // 0-禁用 1-启用
            $table->timestamps();
            $table->softDeletes();
            $table->comment('钱包类型');
        });
        DB::insert("insert into wallet_types(id,name,slug,description,decimal_places,is_enabled)
			values(?,?,?,?,?,?)", [1, '余额', 'MONEY', '余额', 2, 1]);
        DB::insert("insert into wallet_types(id,name,slug,description,decimal_places,is_enabled)
			values(?,?,?,?,?,?)", [2, '积分', 'CREDIT', '积分', 2, 1]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('wallet_types');
    }
};
