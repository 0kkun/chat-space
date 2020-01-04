Rails.application.routes.draw do
  devise_for :users
  root to: 'messages#index'

  #登録情報を編集するためのルーティングを定義
  resources :users, only: [:edit, :update]

end
