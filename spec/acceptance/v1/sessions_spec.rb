require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Sessions" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/users/sign_in" do
    let(:user) { create :user, password: "123456" }

    parameter :email, "Email", required: true
    parameter :password, "Password", required: true

    let(:email) { user.email }

    example_request "Sign in with valid password", password: "123456" do
      expect(response["user"]).to be_a_session_representation
    end
  end
end
