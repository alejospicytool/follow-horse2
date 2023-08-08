class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.writer_id = current_user.id
    @review.user_id = @user.id
    if @review.save
      redirect_to profile_show_path(@user), notice: "Reseña creada correctamente, será revisada por un administrador"
    else
      redirect_to profile_show_path(@user), notice: "Datos incorrectos, por favor reviselos e intente nuevamente"
      # flash[:alert] = "Datos incorrectos, por favor reviselos e intente nuevamente"
      # render "profiles/show", status: :unprocessable_entity
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
    if review.save
      redirect_to admin_reviews_pending_path
    else
      redirecto_to admin_reviews_pending_path, alert: "No se pudo aprobar la review, intente nuevamente"
    end
  end

  def disapprove
    review = Review.find(params[:id])
    review.approve = false
    if review.save
      redirect_to admin_reviews_resolved_path
    else
      redirecto_to admin_reviews_resolved_path, alert: "No se pudo desaprobar la review, intente nuevamente"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :user_id, :writer_id)
  end
end
