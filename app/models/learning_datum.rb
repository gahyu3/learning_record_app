class LearningDatum < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :learning_subject, presence: { message: 'は必ず入力してください' }, length: { maximum: 50, message: 'は50文字以内で入力してください'}
  validates :time, presence: { message: 'は必ず入力してください' }, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の数字で入力してください'}
  validate :unique_learning_subject_month

  private

    def unique_learning_subject_month
      if LearningDatum.where(user_id: user_id, learning_subject: learning_subject)
        .where("to_char(date, 'YYYY-MM') = ?", date.strftime("%Y-%m"))
        .exists?
        errors.add(:learning_subject, "は既に登録されています")
      end
    end

end
