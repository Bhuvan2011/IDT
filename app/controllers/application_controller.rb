class ApplicationController < ActionController::Base
  protect_from_forgery

   # Filters:
  # before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def options
    # Required for cross-site browser requests (see routes.rb file for constraints: {method: 'OPTIONS'})
    render :text => '', :content_type => 'text/plain'
  end

  protected

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type, X-User-Access-Token'
    headers['Access-Control-Max-Age'] = '1728000'
  end

end
