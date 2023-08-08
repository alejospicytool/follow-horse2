class AdminController < ApplicationController
  before_action :sub_links

  def help_contact_pending
    @section_title = "Consultas"
    @consultas = Help.where(resolved: false)
  end

  def help_contact_resolved
    @section_title = "Consultas"
    @consultas = Help.where(resolved: true)
  end

  def help_update
    help = Help.find(params[:id])
    if help.resolved == false
      help.resolved = true
      if help.save
        redirect_to admin_help_contact_pending_path
      else
        redirecto_to admin_help_contact_pending_path, alert: "No se pudo actualizar, intente nuevamente"
      end
    else
      help.resolved = false
      if help.save
        redirect_to admin_help_contact_resolved_path
      else
        redirecto_to admin_help_contact_resolved_path, alert: "No se pudo actualizar, intente nuevamente"
      end
    end
  end

  def reviews_pending
    @section_title = "Reseñas"
    @reviews = Review.all.where(approve: false)
  end

  def reviews_resolved
    @section_title = "Reseñas"
    @reviews = Review.all.where(approve: true)
  end

  def sub_links
    @sub_links_help = [
      {title: "Pendientes", path: admin_help_contact_pending_path},
      {title: "Resueltas", path: admin_help_contact_resolved_path}
    ]

    @sub_links_reviews = [
      {title: "No aprobadas", path: admin_reviews_pending_path},
      {title: "Aprobadas", path: admin_reviews_resolved_path}
    ]
  end
end
