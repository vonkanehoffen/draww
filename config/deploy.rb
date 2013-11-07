set :application, 'Draww'
set :repo_url, 'https://github.com/vonkanehoffen/draww.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deployer/draww'
set :scm, :git
set :branch, 'master'

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# note: database.yml had to be touched on the remote server first.
set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end

  after "deploy:setup", "deploy:setup_config"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
