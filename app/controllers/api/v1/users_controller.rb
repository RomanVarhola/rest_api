module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :admin_user!, only: [:edit, :create, :destroy] 
      before_action :set_user, only: [:show, :edit, :update, :destroy]

      def index
        if current_api_v1_user.admin?
          @users = User.all
        else
          @users = User.only_users
        end
        render json: { data: @users }
      end

      def show
        render json: { data: @user }
      end
      
      def edit
        render json: { data: @user }
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { data: @user }
        else
          render json: @user.errors
        end
      end

      def update
        if @user.update(user_params)
          render json: { data: @user }
        else
          render json: @user.errors
        end
      end

      def destroy
        @user.destroy
        render json: { data: @user }
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :number_phone, :email, :password)
      end
    end  
  end
end