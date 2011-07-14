#set :application, "set your application name here"
#set :repository,  "set your repository location here"

#set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# RVM integration
# http://beginrescueend.com/integration/capistrano/
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                               # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby'                           # Or whatever env you want it to run in.
set :rvm_type, :user                                   # Copy the exact line. I really mean :user here

set :default_environment, {
  'PATH' => "$HOME/.rvm/gems/ree/1.8.7/bin:/path/to/.rvm/bin:/path/to/.rvm/ree-1.8.7-2009.10/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2',
  'GEM_HOME'     => '$HOME/.rvm/gems/ruby-1.9.2-p180',
  'GEM_PATH'     => '$HOME/.rvm/gems/ruby-1.9.2-p180',
#  'BUNDLE_PATH'  => '$HOME/.rvm/gems/ruby-1.9.2-p180'  # If you are using bundler.
}

# http://gembundler.com/deploying.html
# Automatic deployment with Capistrano
require 'bundler/capistrano'


set :application, "nwn"
set :rails_env, "production"
set :domain, "anti@firstvds"
set :deploy_to, "/vault/production/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"


set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  "git@github.com:advsm/nwn_quotes.git" # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить их в deployment keys в настройках репозитария.
set :branch, "master" # Ветка из которой будем тянуть код для деплоя.
#set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

#role :web, "nwn.name"
role :app, "62.109.21.110"
#role :db,  "nwn.name", :primary => true

after 'deploy:update_code', :roles => :app do
  # change mongoid.yml with symlink to shared libraries
  run "rm -f #{current_release}/config/mongoid.yml"
  run "ln -s #{deploy_to}/shared/config/mongoid.yml #{current_release}/config/mongoid.yml"
end

# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end
