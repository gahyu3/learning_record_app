class LearningDatum < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :learning_subject, presence: { message: 'は必ず入力してください' }, length: { maximum: 50, message: 'は50文字以内で入力してください'}
  validates :time, presence: { message: 'は必ず入力してください' }, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の数字で入力してください'}
  validate :unique_learning_subject_month, on: :create

  scope :this_month, -> {where(date: Date.today.beginning_of_month..Date.today.end_of_month)}
  scope :last_month, -> {where(date: Date.today.prev_month.beginning_of_month..Date.today.prev_month.end_of_month)}
  scope :two_month_ago, -> {where(date: Date.today.prev_month.prev_month.beginning_of_month..Date.today.prev_month.prev_month.end_of_month)}

  private

    def unique_learning_subject_month
      if LearningDatum.where(user_id: user_id, learning_subject: learning_subject)
        .where("to_char(date, 'YYYY-MM') = ?", date.strftime("%Y-%m"))
        .exists?
        errors.add(:learning_subject, "は既に登録されています")
      end
    end


end
