module Api::V1
  class UsersController < BaseController
    def index
      @users = User.page(params[:page])
      respond_with @users
    end
  end
end
