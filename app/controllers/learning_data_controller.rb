class LearningDataController < ApplicationController

  def new
    @learning_data = LearningDatum.new
    @date = params[:month].present? ? Date.parse(params[:month]) : Date.today
    @category = Category.find(params[:category_id])
  end

  def create
    @learning_data = current_user.learning_data.build(learning_data_params)
    if @learning_data.save
      flash[:learning_subject] = @learning_data.learning_subject + 'を'
      flash[:learning_time] = @learning_data.time
      redirect_to new_learning_datum_path
    else
      session[:subject] = @learning_data.learning_subject
      session[:time] = @learning_data.time
      flash[:subject] = @learning_data.errors.full_messages_for(:learning_subject)
      flash[:time] = @learning_data.errors.full_messages_for(:time)
      redirect_to new_learning_datum_path
    end
  end


  def edit
    session[:subject] = nil
    session[:time] = nil
    @month =  if params[:month].present?
                Date.parse(params[:month]).strftime("%Y-%m")
              else
                Date.today.strftime("%Y-%m")
              end
    @learning_data_backend = current_user.learning_data.where(category_id: 1).where("to_char(date, 'YYYY-MM') = ?", @month).order(:id)
    @learning_data_frontend = current_user.learning_data.where(category_id: 2).where("to_char(date, 'YYYY-MM') = ?", @month).order(:id)
    @learning_data_infrastructur = current_user.learning_data.where(category_id: 3).where("to_char(date, 'YYYY-MM') = ?", @month).order(:id)
  end

  def update
    @learning_data = current_user.learning_data.find(params[:id])
    if @learning_data.update(learning_data_params)
      flash[:learning_subject] = @learning_data.learning_subject + 'の学習時間を保存しました！'
      redirect_to edit_learning_datum_path(current_user, month: @learning_data.date)
    else
      redirect_to edit_learning_datum_path(current_user,  month: @learning_data.date)
    end
  end

  def destroy
    @learning_data = current_user.learning_data.find(params[:id])
    if @learning_data.destroy!
      flash[:learning_subject] = @learning_data.learning_subject + 'を削除しました！'
      redirect_to edit_learning_datum_path(current_user, month: @learning_data.date)
    end
  end

  private

  def learning_data_params
    params.require(:learning_datum).permit(:learning_subject, :time, :date, :category_id)
  end
end
