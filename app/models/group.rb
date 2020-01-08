class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true
  has_many :messages


  def show_last_message
    if (last_message = messages.last).present? #presentメソッド：値が存在するかどうか。するならtrueを返す
      if last_message.content?
        last_message.content
       else
         '画像が投稿されています'
       end
      #三項演算子を使って、下記のように一行で記述することもできる
      #last_message.content? ? last_message.content : '画像が投稿されています'
    else
      'まだメッセージはありません。'
    end
  end


end
