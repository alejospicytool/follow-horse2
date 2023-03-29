class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.writer_id = current_user.id
    @review.user = @user
    if @review.save
      redirect_to profile_show_path(@user)
    else
      flash[:alert] = "Something went wrong."
      render "profiles/show", status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
    redirect_to user_path(@review.user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to user_path(@review.user), notice: "Se elimino correctamente la review"
    else
      render 'user/show', alert: "No se pudo eliminar la review, intente nuevamente"
    end
  end

  def approve
    review = Review.find(params[:id])
    review.approve = true
    user = User.find(review.user_id)
    if review.save
      user.update_rating
      redirect_to profile_show_path(user)
    else
      redirecto_to home_path, alert: "No se pudo eliminar la review, intente nuevamente"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :user_id, :writer_id)
  end
end
