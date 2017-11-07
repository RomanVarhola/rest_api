module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :admin_user!, only: [:edit, :create, :update, :destroy]
      before_action :set_user, only: [:show, :edit, :update, :destroy]

      helper_method :sort_column, :sort_direction

      def index
        if current_api_v1_user.admin?
          @users = User.all.paginate(page: params[:page], per_page: 10).search(filter_params).order("#{sort_column} #{sort_direction}")
        else
          @users = User.only_users.paginate(page: params[:page], per_page: 10).order("#{sort_column} #{sort_direction}")
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
          render json: { data: @user, status: :created }
        else
          render json: @user.errors
        end
      end

      def update
        if @user.update(user_params)
          render json: { data: @user, status: :updated }
        else
          render json: @user.errors
        end
      end

      def destroy
        @user.destroy
        render json: { data: @user, status: :destroyed }
      end

      private

      def set_user
        if current_api_v1_user.admin?
          @user = User.find(params[:id])
        else
          @user = current_api_v1_user
        end
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :number_phone, :email, :password)
      end

      def filter_params
        params[:filter]
      end

      def sort_column
        params[:sort].present? ? params[:sort] : "email"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end
    end  
  end
end