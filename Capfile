# capistrano全体の設定ファイル
# require により引数としておかれた文字列が指すディレクトリが読み込まれる
# その中にデプロイに際して必要な動作が一通り記述

require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }