class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #before_actionは、全てのアクションが行われる前に処理を実行させたい時に使用する
  #:authenticate_user!は、ユーザがログインしていない場合はログインページにリダイレクトさせる
  before_action :authenticate_user!
  
  #作成したモデルにストロングパラメーターを追加したい場合に使用
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #新規登録時のストロングパラメータに「nameカラム」の追加
  #sign_up： 新規登録時   |   sign_in： ログイン時   |   account_update： 更新時
  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
