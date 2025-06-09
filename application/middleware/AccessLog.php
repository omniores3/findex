<?php
namespace app\middleware;

use think\facade\Log;

class AccessLog
{
    public function handle($request, \Closure $next)
    {
        $response = $next($request);
        
        // 记录访问日志
        $log = sprintf(
            "[%s] %s %s %s",
            date('Y-m-d H:i:s'),
            $request->ip(),
            $request->method(),
            $request->url()
        );
        
        file_put_contents(
            runtime_path('log/access.log'),
            $log . PHP_EOL,
            FILE_APPEND
        );
        
        return $response;
    }
}