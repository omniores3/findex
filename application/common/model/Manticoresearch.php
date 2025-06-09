<?php

namespace app\common\model;




use PDOException;

class Manticoresearch
{
    public function __construct($dbname){
        $config = config('site');
        $host = $config['manticorehost'] ?? 'localhost';
        $port = $config['manticoreport'] ?? 9306;
        $dsn = "mysql:host={$host};port={$port};dbname=".$dbname;
        $username = "";
        $password = "";

        try {
            $connection = new \PDO($dsn, $username, $password);
            dump($connection);
        } catch (PDOException $e) {
            echo "Connection failed: " . $e->getMessage();
    die;
}
    }
}