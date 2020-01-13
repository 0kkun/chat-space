Rails.application.routes.draw do
  devise_for :users
  #root to: 'messages#index'
  root 'groups#index'

  #登録情報を編集するためのルーティングを定義
  resources :users, only: [:index, :edit, :update]
  
  #グループが存在しないとメッセージの投稿ができないようにするために、
  #メッセージをグループの下にネスト(入れ子化)している。
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    #投稿されたメッセージの一覧表示 & メッセージの入力ができる:index
    #メッセージの保存を行う:create
    resources :messages, only: [:index, :create]

    # チャット自動更新用のapiのためのルーティング
    # namespaceを使用した書き方
    # ディレクトリ内(apiフォルダ)のコントローラのアクションを指定できる
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end

end
