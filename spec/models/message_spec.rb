require 'rails_helper'

# ------テスト内容------
# メッセージを保存できる場合
#   - メッセージがあれば保存できる
#   - 画像があれば保存できる
#   - メッセージと画像があれば保存できる
# メッセージを保存できない場合
#   - メッセージも画像も無いと保存できない
#   - group_idが無いと保存できない
#   - user_idが無いと保存できない

RSpec.describe Message, type: :model do
  describe '#create' do

    #保存できる場合
    context 'can save' do #条件分岐させて表示したい時はcontextを使用する
      # メッセージがあれば保存できる
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
      end

      # 画像があれば保存できる
      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end

      # メッセージと画像があれば保存できる
      it 'is valid with content and image' do
        expect(build(:message)).to be_valid
      end
    end

    #保存できない場合
    context 'can not save' do
      # メッセージも画像も無いと保存できない
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      #group_idが無いと保存できない
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      # user_idが無いと保存できない
      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
