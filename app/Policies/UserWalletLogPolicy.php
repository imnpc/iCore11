<?php

namespace App\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;
use Sereny\NovaPermissions\Policies\BasePolicy;

class UserWalletLogPolicy extends BasePolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * The Permission key the Policy corresponds to.
     *
     * @var string
     */
    public $key = 'UserWalletLog';

}
