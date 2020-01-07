class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  #contentカラムとimageカラムのバリデーション設定
  #imageカラムが空の場合、contentカラムも空であれば保存しないという意味
  validates :content, presence: true, unless: :image?

  #gemインストールして、uploader imageを生成したので、
  #messageモデルとimage_uploaderをマウントする
  mount_uploader :image, ImageUploader
end
