class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_optional_error(404)
  end

  def render_optional_error(status_code)
    status = status_code.to_s
    fname = %w(404 403 422 500).include?(status) ? status : 'unknown'
    render template: "/errors/#{fname}", formats: [:html],
           handler: [:erb], status: status, layout: request.fullpath.to_s.index('/admin') ? 'admin_boot' : 'application'
  end
end
