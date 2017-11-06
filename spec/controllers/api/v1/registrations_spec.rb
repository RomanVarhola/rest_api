require 'rails_helper'
 
RSpec.describe Api::V1::RegistrationsController, type: :controller do
  
  describe "PUT #create" do
    context "with valid params" do
      it "sign up user" do
        post :create, params: { user: { email: random_email, password: password }}
        expect_json_to_have_data_id
      end
    end

    context "with invalid params" do
      it "sign up user" do
        post :create, params: { user: { email: random_email }}
        expect_json_to_get_error_after_registration
      end
    end
  end
end
