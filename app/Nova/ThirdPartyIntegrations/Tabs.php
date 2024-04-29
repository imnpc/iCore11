<?php

namespace App\Nova\ThirdPartyIntegrations;

use KirschbaumDevelopment\NovaInlineRelationship\Integrations\ThirdParty;
use KirschbaumDevelopment\NovaInlineRelationship\Integrations\Contracts\ThirdPartyContract;

class Tabs extends ThirdParty implements ThirdPartyContract
{
    /**
     * Fields array from object.
     *
     * @return array
     */
    public function fields(): array
    {
        return $this->field->data;
    }
}

