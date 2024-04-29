<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Spatie\QueryBuilder\QueryBuilder;
use Vinkla\Hashids\Facades\Hashids;

class UserController extends Controller
{
    /**
     * 注册
     * @param Request $request
     * @return mixed
     */
    public function store(Request $request)
    {
        $request->validate([
            'phone' => 'required|phone:CN,mobile|unique:users,mobile',
            'password' => 'required|string|min:6|confirmed',
            'parent_id' => 'string',
            'nickname' => 'required|string',
        ]);

        $mobile = $request->phone;
        $parent_id = 0;

        // 上级邀请码
        if ($request->parent_id) {
            $decode_id = Hashids::decode($request->parent_id); // 解密传递的 ID
            if (empty($decode_id)) {
                return $this->fail('邀请码不正确！', 403);
            }
            $parent_id = $decode_id[0];// 解密后的 ID
        }

        // 创建用户
        $user = User::create([
            'mobile' => $mobile,
            'nickname' => $request->nickname,
            'password' => bcrypt($request->password),
            'parent_id' => $parent_id,
        ]);

        $token = $user->createToken('api')->plainTextToken;
        $data = ['token_type' => "Bearer", 'expires_in' => 1296000, 'access_token' => $token, 'user_id' => $user->id];

        return $this->success($data, '注册成功', 200);
    }

    /**
     * 登录
     * @param Request $request
     * @return mixed
     */
    public function login(Request $request)
    {
        $this->validate($request, [
            'phone' => 'required|phone:CN,mobile|exists:users,mobile',
            'password' => 'required',
        ]);

        $mobile = $request->phone;
        $password = $request->input('password');

        $user = User::where('mobile', $mobile)->first();

        if ($user) {
            if (!Hash::check($password, $user->password)) {
                return $this->fail('密码错误', 403);
            } else {
                if ($user->is_banned == 1) {
                    return $this->fail('您的账户已被暂停, 请联系网站管理员', 403);
                }
                $token = $user->createToken('api')->plainTextToken;
                $data = ['token_type' => "Bearer", 'expires_in' => 1296000, 'access_token' => $token, 'user_id' => $user->id];
                return $this->success($data, '登录成功', 200);
            }
        } else {
            return $this->fail('账号不存在！', 403);
        }
    }

    /**
     * 当前登录用户详细信息
     * @param Request $request
     * @return User|mixed
     */
    public function me(Request $request)
    {
        $user = $request->user();

        return $this->success(new UserResource($user));
    }

    /**
     * 我的邀请码
     * @param Request $request
     * @return mixed
     */
    public function invite(Request $request)
    {
        $user = $request->user();
        $code = Hashids::encode($user->id);
        $url = config('app.reg_url') . "/#/pages/user/register?invite_code=" . $code;
        $data['code'] = $code;
        $data['url'] = $url;

        if (config('app.env') == 'local') {
            $path = 'qrcode/dev/' . $code . '.png'; // 二维码图片名称路径 TODO
        } else {
            $path = 'qrcode/' . $code . '.png'; // 二维码图片名称路径
        }

        $exists = Storage::disk(config('filesystems.default'))->exists($path); // 查询文件是否存在
        if (!$exists) {
            // 不存在就生成并上传二维码图片
            $qr = QrCode::format('png')->size(300)->margin(0)->errorCorrection('L')->generate($url);
            Storage::disk(config('filesystems.default'))->put($path, $qr); //上传到 OSS
        }

        $data['qrcode'] = Storage::disk(config('filesystems.default'))->url($path); // 返回图片 URL

        return $this->success($data, '获取邀请码成功', 200);
    }

    /**
     * 我的推广记录
     * @param Request $request
     * @return mixed
     */
    public function team(Request $request)
    {
        $user = $request->user();

        $list = QueryBuilder::for(User::class)
            ->defaultSort('-created_at')
            ->where('parent_id', '=', $user->id)
            ->paginate();

        return $this->success(new UserResource($list));
    }

    public function test()
    {
        Cache::put('nova_valid_license_key', 1);
//        Cache::remember('nova_valid_license_key', 3600, function () {
//            return 1;
//        });
    }
}
