require 'rails_helper'
require 'faker'
require 'json_matchers/rspec'

RSpec.describe UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      "email": Faker::Internet.email,
      "password": "password"
    }
  }

  let(:invalid_attributes) {
    {
      "email": "invalid email",
      "password": "password"
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { { } }

  describe "GET #index" do
    it "returns a success response" do
      FactoryBot.create(:user)
      get :index, params: { :format => :json }
      expect(response).to be_successful
      expect(response.body).to match_response_schema('users')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      get :show, params: { :format => 'json', id: user.id.to_param }
      expect(response).to be_successful
      expect(response.body).to match_response_schema('user')
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { :format => 'json', user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(201)
        expect(response.body).to match_response_schema('user_create')
      end
    end

    context "with invalid params" do
      it "returns a 422 (Unprocessable Entity response)" do
        post :create, params: { :format => 'json', user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          email: Faker::Internet.email
        }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: { :format => 'json', id: user.to_param, user: new_attributes }
        user.reload
        expect(response).to be_successful
        expect(user.email).to eq(new_attributes[:email])
      end
    end

    context "with invalid params" do
      it "returns a 422 (Unprocessable Entity response)" do
        user = User.create! valid_attributes
        put :update, params: { :format => 'json', id: user.to_param, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: { :format => 'json', id: user.to_param }
      }.to change(User, :count).by(-1)
    end
  end

end
