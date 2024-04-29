<?php

namespace App\Nova\Actions\Url;

use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Collection;
use Laravel\Nova\Actions\Action;
use Laravel\Nova\Fields\ActionFields;
use Laravel\Nova\Http\Requests\NovaRequest;
use Laravel\Nova\Nova;
use Lednerb\ActionButtonSelector\ShowAsButton;

class UserWalletLogTo extends Action
{
    use InteractsWithQueue, Queueable;
    use ShowAsButton;

    public $user;

    public function __construct(User $user = null)
    {
        $this->user = $user;
    }

    public function name()
    {
        return $this->name ?? __('UserWalletLog');
    }

    /**
     * Perform the action on the given models.
     *
     * @param \Laravel\Nova\Fields\ActionFields $fields
     * @param \Illuminate\Support\Collection $models
     * @return mixed
     */
    public function handle(ActionFields $fields, Collection $models)
    {
        $data = $models->toArray();
        $id = $data[0]['id'];
        $filter = base64_encode(json_encode([['resource:users:user' => $id]]));
        $filter_url = Nova::path() . '/resources/user-wallet-logs?user-wallet-logs_filter=' . urlencode($filter);
        return Action::openInNewTab($filter_url);
    }

    /**
     * Get the fields available on the action.
     *
     * @param \Laravel\Nova\Http\Requests\NovaRequest $request
     * @return array
     */
    public function fields(NovaRequest $request)
    {
        return [

        ];
    }
}
