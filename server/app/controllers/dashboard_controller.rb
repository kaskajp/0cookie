class DashboardController < ApplicationController
  before_action :require_login

  def index
    @workspaces = current_user.workspaces
  end
end


