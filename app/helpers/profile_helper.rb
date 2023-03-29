module ProfileHelper
  def user_rating
    (@user.rating * 2.0).round / 2.0
  end
end
