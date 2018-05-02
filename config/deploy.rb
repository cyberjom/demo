# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

set :pty,             true
set :use_sudo,        false
set :application,     'demo'
set :deploy_user,     'deploy'
set :deploy_to,       "/content/www/#{fetch(:application)}"

# setup repo details
set :repo_url,        'git@github.com:cyberjom/demo.git'

server '10.2.1.74', user: 'root', port: 22, roles: [:web, :app, :db], primary: true
# set :ssh_options,     { forward_agent: true, keys: %w(~/.ssh/id_rsa.pub) }

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

## Puma 
# set :puma_threads,    [4, 16]
# set :puma_workers,    4
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, false  # Change to true if using ActiveRecord


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end
#
#   before :start, :make_dirs
# end
#
namespace :deploy do
  desc 'Stop God Job'
  task :god_stop do
    on roles(:app) do
      execute :god, :stop, "#{fetch(:application)}-production"
    end
  end

  desc 'Start God Job'
  task :god_start do
    on roles(:app) do
      execute :god, :start, "#{fetch(:application)}-production"
    end
  end

  before :starting,     :god_stop
  after  :finishing,    :god_start
end
