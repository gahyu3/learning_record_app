class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :name, presence: { message: 'は必ず入力してください' }, length: { maximum: 255, message: 'は255文字以内で入力してください'}
  validates :email, presence: { message: 'は必ず入力してください' }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'が正しい形式ではありません' }
  validates :password, presence: { message: 'は必ず入力してください' }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).{6,}\z/, message: 'は英数字8文字以上で入力してください' }

end
