daemonize true
bind "unix://tmp/sockets/puma_dev.sock"
pidfile "tmp/pids/puma_dev.pid"
stdout_redirect 'log/puma_dev.log', 'log/puma_dev_error.log', true
state_path 'tmp/pids/puma_dev.state'
