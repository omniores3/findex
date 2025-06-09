<?php

namespace app\common\library;

use Meilisearch\Client;

class Meilisearch
{

    private $client;


    public function __construct()
    {
        $config = config("site");
        $this->client = new Client($config["meiliurl"], $config["meili_key"]);
    }

    public function getClient(){
        return $this->client;
    }
}