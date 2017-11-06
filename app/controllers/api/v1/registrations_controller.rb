module Api
  module V1
    class RegistrationsController < ApplicationController
      respond_to :json

      def create
        user = User.new(user_params)
        if user.save
          render json:{ data: user.as_json(email: user.email)}, status: 201
          return
        else
          warden.custom_failure!
          render json: user.errors, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :number_phone, :email, :password)
      end
    end
  end
end


