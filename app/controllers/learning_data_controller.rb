class LearningDataController < ApplicationController

  def new
    @learning_data = LearningDatum.new
    @date = params[:month].present? ? Date.parse(params[:month]) : Date.today
    @category = Category.find(params[:category_id])
  end

  def create
    @learning_data = current_user.learning_data.build(learning_data_params)
    if @learning_data.save
      flash[:notice] = @learning_data.learning_subject
      flash[:learning_time] = @learning_data.time
      redirect_to new_learning_datum_path
    else
      flash[:subject] = @learning_data.errors.full_messages_for(:learning_subject)
      flash[:time] = @learning_data.errors.full_messages_for(:time)
      redirect_to new_learning_datum_path
    end
  end


  def edit
    @month = params[:month].present? ? Date.parse(params[:month]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    @learning_data_backend = current_user.learning_data.where(category_id: 1).where("to_char(date, 'YYYY-MM') = ?", @month)
    @learning_data_frontend = current_user.learning_data.where(category_id: 2).where("to_char(date, 'YYYY-MM') = ?", @month)
    @learning_data_infrastructur = current_user.learning_data.where(category_id: 3).where("to_char(date, 'YYYY-MM') = ?", @month)
  end

  private

  def learning_data_params
    params.require(:learning_datum).permit(:learning_subject, :time, :date, :category_id)
  end
end
