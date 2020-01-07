class GroupsController < ApplicationController

  def index
  end
  
  def new #新規グループ作成画面を表示させる
    @group = Group.new #Groupモデルの新しいインスタンス変数を生成する
    @group.users << current_user #現在ログイン中のユーザーを、@groupに追加する
  end

  #クリエイトアクションの指示が来たら、ストロングパラメータで許可されたカラムのみに対して
  #インスタンス変数を生成する。
  #もしインスタンス変数にて、新しいデータのsaveに成功した場合は、ルートを表示(リダイレクト)し、
  #通知メッセを表示する。そうじゃないなら、newのビューを表示する。
  def create 
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  private
  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end

end
