class HomeController < ApplicationController
  def version
    render :text => `git log -1`
  end
  
  # static pages, rendered through views
  [:history, :place, :promote, :soon, :sponsors].each do |s|
    module_eval <<-EOS
    def #{s}; end
    EOS
  end
end
