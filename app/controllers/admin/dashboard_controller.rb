class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['auth_username'], password: ENV['auth_password']

  def show
  end
end
