daemonize true
bind "unix://tmp/sockets/puma.sock"
pidfile "tmp/pids/puma.pid"
stdout_redirect 'log/puma.log', 'log/puma_error.log', true
state_path 'tmp/pids/puma.state'

