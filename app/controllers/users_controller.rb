class UsersController < ApplicationController

  #ルーティングで定義したresources :editに対応するアクション
  def edit
  end

  #ルーティングで定義したresources :updateに対応するアクション
  #保存できた場合、できなかった場合でif分岐させている
  #もしcurrent_user.updateに成功した場合はrootを表示し、
  #失敗した場合は再度editビュー画面を表示する
  def update
    if current_user.update(user_params) #true
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  #ストロングパラメータを定義
  #nameカラムとemailカラムの入力を許可している
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
