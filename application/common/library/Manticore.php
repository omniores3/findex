<?php
namespace app\common\library;

use Manticoresearch\Client;
use think\Exception;

class Manticore
{
    protected $client;
    protected $config;

    public function __construct()
    {
        $this->config = config('site');
        $this->client = new Client([
            'host' => $this->config['manticorehost'] ?? 'localhost',
            'port' => $this->config['manticoreport'] ?? 9308
        ]);
    }

    public function getClient(){
        return $this->client;
    }


    /**
     * 创建索引
     * @param string $indexName 索引名称
     * @param array $schema 索引结构
     * @return bool
     */
    public function createIndex($indexName, $schema)
    {
        try {
            $index = $this->client->index($indexName);
            $index->create($schema);
            return true;
        } catch (\Exception $e) {
            throw new Exception("创建索引失败: " . $e->getMessage());
        }
    }

    /**
     * 删除索引
     * @param string $indexName 索引名称
     * @return bool
     */
    public function dropIndex($indexName)
    {
        try {
            $this->client->index($indexName)->drop();
            return true;
        } catch (\Exception $e) {
            throw new Exception("删除索引失败: " . $e->getMessage());
        }
    }

    /**
     * 添加/更新文档
     * @param string $indexName 索引名称
     * @param array $document 文档数据
     * @param int|null $id 文档ID
     * @return bool
     */
    public function replaceDocument($indexName, $document, $id = null)
    {
        try {
            $index = $this->client->index($indexName);
            $doc = $index->replaceDocument($document, $id);
            return $doc->isSuccess();
        } catch (\Exception $e) {
            throw new Exception("文档操作失败: " . $e->getMessage());
        }
    }

    /**
     * 删除文档
     * @param string $indexName 索引名称
     * @param int $id 文档ID
     * @return bool
     */
    public function deleteDocument($indexName, $id)
    {
        try {
            $index = $this->client->index($indexName);
            $doc = $index->deleteDocument($id);
            return $doc->isSuccess();
        } catch (\Exception $e) {
            throw new Exception("文档删除失败: " . $e->getMessage());
        }
    }

    /**
     * 搜索文档
     * @param string $indexName 索引名称
     * @param array $query 查询条件
     * @param array $options 查询选项
     * @return array
     */
    public function search($indexName, $query, $options = [])
    {
        try {
            $search = $this->client->index($indexName)->search($query);
            
            // 设置查询选项
            foreach ($options as $key => $value) {
                $search->set($key, $value);
            }
            
            $results = $search->get();
            return $results->getResponse()->getData();
        } catch (\Exception $e) {
            throw new Exception("搜索失败: " . $e->getMessage());
        }
    }

    /**
     * 批量操作
     * @param string $indexName 索引名称
     * @param array $operations 批量操作数组
     * @return bool
     */
    public function bulk($indexName, $operations)
    {
        try {
            $bulk = new \Manticoresearch\Bulk($this->client);
            $bulk->index($indexName);
            
            foreach ($operations as $op) {
                if ($op['action'] === 'insert') {
                    $bulk->addDocument($op['document'], $op['id'] ?? null);
                } elseif ($op['action'] === 'update') {
                    $bulk->updateDocument($op['document'], $op['id']);
                } elseif ($op['action'] === 'delete') {
                    $bulk->deleteDocument($op['id']);
                }
            }
            
            return $bulk->send();
        } catch (\Exception $e) {
            throw new Exception("批量操作失败: " . $e->getMessage());
        }
    }
}