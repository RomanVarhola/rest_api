require 'rails_helper'
 
RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { User.create!(email: random_email, password: password, role: 0) }

  describe "PUT #create" do
    context "with valid params" do
      it "log in user" do
        request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
        post :create, params: { email: user.email, password: user.password }
        expect(json['id']).to eq user.id
      end
    end

    context "with invalid params" do
      it "log in user" do
        request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
        post :create, params: { email: user.email, password: '123456' }
        expect(json['message']).to eq 'Wrong password!'
      end
    end
  end

  describe "DELETE #destroy" do
    it "log out user" do
      request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
      sign_in(user)
      delete :destroy, params: {id: user.to_param}
      expect(json['message']).to eq 'Sign out!'
    end
  end
end
