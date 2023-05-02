module ProfileHelper
  def user_rating
    begin
    (@user.rating * 2.0).round / 2.0
    rescue
    "Sin reseñas recibidas"
    end
  end
end
