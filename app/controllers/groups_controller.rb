class GroupsController < ApplicationController

  #editアクションの定義をしなくても、edit.htmlは自動で表示できる
  #editのルーティングと、それに対応するedit.htmlビューがあれば表示できる

  #アクションが行われる前に、set_groupメソッドを実行する
  #set_groupメソッドを実行するとgroupというインスタンス変数を生成する
  #onlyは、editアクションとupdateアクションにのみ、有効とするという意味
  before_action :set_group, only: [:edit, :update]

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

  #グループの内容を更新する時のアクション
  #
  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end
  
  private

  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
