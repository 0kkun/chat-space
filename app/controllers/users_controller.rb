class UsersController < ApplicationController

  # インクリメンタルサーチ実装。
  # 新規グループ作成画面で、文字が入力される度にjbuilderが呼ばれるように設定する
  # views >> users >> index.json.jbuilderが呼ばれる
  def index
    # params[:keyword]に値が入っていればそのまま処理は続けられ、空だった場合はそこで処理が終わる
    return nil if params[:keyword] == ""
    # 値(input)を含むデータをDBから取得するようにコントローラで処理する
    # whereメソッドで、入力された値を含むかつ、ログインしているユーザーのidは除外するという条件で取得
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    
    respond_to do |format|
      format.html
      format.json
    end

  end

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
