class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['auth_username'], password: ENV['auth_password']

  def show
    @categories = Category.select("categories.name as category_name, sum(quantity) as total_quantity")
    .joins(:products).group("category_name")

    @products = Product.sum("quantity")
  end
end

