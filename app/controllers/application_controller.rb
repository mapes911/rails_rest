class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  # any time we get a RecordNotFound Exception we're going to rescue from it and throw a 404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # apparently, this way of handling routing errors is old (pre 3.x) so it won't work :)
  rescue_from ActionController::RoutingError, :with => :render_404

  private
    # Used to take the user to a 404 page
    def render_404
      render :file => "#{Rails.root.to_s}/public/404", :formats => [:html], :status => 404
      true
    end

end
