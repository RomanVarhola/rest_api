module Api
  module V1
    class SessionsController < Devise::SessionsController
      
      def new
        render json: { message: 'You are on method #GET. Please, use method #POST.', status: :ok }
      end

      def create
        @user = User.where(email: params[:email]).first

        if @user.valid_password?(params[:password])
          sign_in(@user)
          render json: current_api_v1_user.as_json(only: [:id, :email], status: :created)
        else
          render json: { message: 'Wrong password!'}
        end
      end

      def destroy
        sign_out(current_api_v1_user)
        render json: { message: 'Sign out!', status: :destroyed}
      end
    end
  end
end