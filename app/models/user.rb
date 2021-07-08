class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # book,いいね,コメントのアソシエーション
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォロー機能部分のアソシエーション
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :user

  # フォロー機能のメソッド
  # 自分とフォロー先が一緒じゃないか検証
  def follow(other_user)
    unless self == other_user
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # 既存のフォロワーならフォロー解除する
  def unfollow(other_user)
    relationships = self.relationships.find_by(follow_id: other_user.id)
    relationships.destroy if relationships
  end

  # フォロワーの中に含まれてない？
  def following?(other_user)
    followings.include?(other_user)
  end

  # プロフィール画像のattachment
  attachment :profile_image

  # validation
  validates :name, length: { in: 2..20 }, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 50 }
end
