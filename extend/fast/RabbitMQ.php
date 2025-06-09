<?php

namespace fast;

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Exception\AMQPProtocolChannelException;
use PhpAmqpLib\Message\AMQPMessage;

class RabbitMQ
{
    private $connection;
    private $channel;
    private $queueName;

    // 初始化RabbitMQ连接
    public function __construct($queueName) {
        $this->queueName = $queueName;
        $config = config("site");
        $this->connection = new AMQPStreamConnection(
            $config['RabbitMQ_host'],
            $config['RabbitMQ_port'],
            $config['RabbitMQ_user'],
            $config['RabbitMQ_password'],
            $config['RabbitMQ_vhost']
        );
        $this->channel = $this->connection->channel();
        // 声明持久化队列
        $this->channel->queue_declare(
            $this->queueName,
            false,
            true,  // 队列持久化
            false,
            false
        );
    }

    /**
     * 获取单条消息API
     * @return array
     */
    public function getMessage() {
        // 设置每次只取一条消息
        $this->channel->basic_qos(null, 1, null);

        $message = null;
        $callback = function($msg) use (&$message) {
            $message = [
                'body' => $msg->body,
                'delivery_tag' => $msg->get('delivery_tag')//$msg->delivery_tag
            ];
        };

        // 非阻塞获取单条消息
        $this->channel->basic_consume(
            $this->queueName,
            '',
            false,
            true,
            false,
            false,
            $callback
        );

        while (count($this->channel->callbacks)) {
            $this->channel->wait(null, false, 1); // 超时1秒
            if($message) break;
        }

        return [
            'code' => $message ? 200 : 404,
            'data' => $message ?: 'No messages'
        ];
    }

    /**
     * 确认删除消息API
     * @param $delivery_tag 消息标识
     */
    public function ackMessage($delivery_tag) {
        try {
            //$this->channel->basic_ack($delivery_tag,true);
            //$this->channel->basic_consume($delivery_tag);
            $this->channel->basic_ack($delivery_tag);
            return json(['code' => 200, 'msg' => 'ACK成功']);
        } catch (\Exception $e) {
            return json(['code' => 500, 'msg' => $e->getMessage()]);
        }
    }

    // 关闭连接
    public function __destruct() {
        $this->channel->close();
        $this->connection->close();
    }
}