class LearningDataController < ApplicationController

  def edit
    @month = params[:month].present? ? Date.parse(params[:month]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    @learning_data_backend = current_user.learning_data.where(category_id: 1).where("to_char(date, 'YYYY-MM') = ?", @month)
    @learning_data_frontend = current_user.learning_data.where(category_id: 2).where("to_char(date, 'YYYY-MM') = ?", @month)
    @learning_data_infrastructur = current_user.learning_data.where(category_id: 3).where("to_char(date, 'YYYY-MM') = ?", @month)
  end
end
