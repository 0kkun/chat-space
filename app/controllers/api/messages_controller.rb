# WebAPIの作成
# APIはアプリケーション開発者が外部に向けてアプリケーションの機能の一部を公開する仕組み
# WebAPIは、HTTPやHTTPS通信を通じて利用するAPIのこと

# Rubyのクラス名は::で繋げて装飾できる。名前空間またはnamespaceと呼ぶ。
# 名前空間を使うと同様のクラス名で名付けたクラスを作ってもそれらを区別することができる
class Api::MessagesController < ApplicationController
  def index
    # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
    group = Group.find(params[:group_id])
    # ajaxで送られてくる最後のメッセージのid番号を変数に代入
    last_message_id = params[:id].to_i
    # 取得したグループでのメッセージ達から、idがlast_message_idよりも新しい(大きい)メッセージ達のみを取得
    @messages = group.messages.includes(:user).where("id > #{last_message_id}")
  end
end