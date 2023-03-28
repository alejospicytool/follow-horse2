class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.writer_id = current_user.id
    if @review.save
      user = User.find(@review.user_id)
      user.update_rating
      redirect_to user_path(@review.user)
    else
      render :new, status: :unprocessable_entity
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

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :user_id, :writer_id)
  end
end
