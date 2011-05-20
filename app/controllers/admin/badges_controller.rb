module Admin
  class BadgesController < ::Admin::Base
    after_filter :set_content_type

    def set_content_type
      headers["Content-Type"] = "image/svg+xml"
    end

    def show
      @registrations = Registration.all()
      respond_to do |format|
        format.svg  { render @registrations => "show.svg.erb", :layout => false }
      end
      # Ruh-roh!
    end
  end
end

