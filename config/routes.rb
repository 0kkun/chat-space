Rails.application.routes.draw do
  devise_for :users
  #root to: 'messages#index'
  root 'groups#index'

  #登録情報を編集するためのルーティングを定義
  resources :users, only: [:edit, :update]
  
  #グループが存在しないとメッセージの投稿ができないようにするために、
  #メッセージをグループの下にネスト(入れ子化)している。
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    #投稿されたメッセージの一覧表示 & メッセージの入力ができる:index
    #メッセージの保存を行う:create
    resources :messages, only: [:index, :create]
  end

end
