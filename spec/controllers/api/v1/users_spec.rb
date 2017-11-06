require 'rails_helper'
 
RSpec.describe Api::V1::UsersController, type: :controller do
  let(:admin_user) { User.create!(email: random_email, password: password, role: 1) }
  let(:user)       { User.create!(email: random_email, password: password, role: 0) }

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
    sign_in(admin_user)
  end

  describe 'GET #index' do
    it 'assigns all users as @users' do
      2.times do |i|
        User.create!(email: random_email, password: password) 
      end
      get :index
      expect_json_data_length_to_be(3)
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create!(email: random_email, password: password)
      get :show, params: { id: user.to_param }
      expect_json_to_contain_id(user.id)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @user" do
      user = User.create!(email: random_email, password: password)
      get :edit, params: { id: user.to_param}
      expect_json_to_contain_id(user.id)
    end
  end

  describe "PUT #create" do
    context "with valid params" do
      it "created the requested user" do
        post :create, params: { user: { email: random_email, password: password }}
        expect_json_to_have_data_id
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested user" do
        user = User.create!(email: random_email, password: password)
        put :update, params: {id: user.to_param, user: { first_name: "Roman", last_name: "Varhola" }}
        expect_json_data_attribute_to_not_match('first_name', user.first_name)
        expect_json_data_attribute_to_not_match('last_name', user.last_name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create!(email: random_email, password: password)
      delete :destroy, params: {id: user.to_param}  
      expect_json_to_contain_id(user.id)
      expect(User.where(id: user.id).to_a.length).to eq 0  
    end
  end
end
