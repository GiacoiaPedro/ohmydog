# app/controllers/user_search_controller.rb

class UserSearchController < ApplicationController
  def search
    if params[:dni].present?
      @users = User.where(dni: params[:dni], habilitado: true)
    else
      @users = []
    end
    render 'users/search'
  end

  
  def perros
    @user = User.find(params[:id])
    @perros = @user.perros
    @vaccine = Vaccine.all
    render 'user_search/perros'
  end

end
