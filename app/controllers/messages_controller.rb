class MessagesController < ApplicationController

  #messagesコントローラの全てのアクションで@groupを利用できるようになる
  before_action :set_group

  def index
    #投稿メッセージ格納用のインスタンス変数
    @message = Message.new
    #n+1問題を解決するために、includeを使用。
    #メッセージとグループを紐付けている状態ではあるが、今のままだとgroupを呼ぶ度に全てのメッセージ
    #を引っ張って来て(SQL発行)しまって処理が重い。なのでincludeでテーブルに予めuserをくっつけてくと処理が軽くなる。
    @messages = @group.messages.includes(:user)
  end


  def create
    @message = @group.messages.new(message_params)
    #保存に成功した場合、保存に失敗した場合で処理を分岐
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
  
  #インスタンス変数を生成するためのメソッドを定義。
  def set_group
    @group = Group.find(params[:group_id])
  end

end
