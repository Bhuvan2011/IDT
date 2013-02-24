require 'spec_helper'

describe RegistrationsController do
  render_views

   describe :create do

    let(:first_name) { 'New Firstname' }
    let(:last_name) { 'New Lastname' }
    let(:email) { 'new@gmail.com' }
    let(:user_name) { 'user_name' }

    let(:post_params) {
        { registration: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        user_name: user_name
      } }
      }

    let(:output) { post(:create, post_params) }

    subject { output }

    before {
      output
    }

    context 'when user parameters are correct' do
      it { should be_success }

      context 'user' do
        subject { assigns(:user) }
        its(:first_name) { should == first_name }
        its(:last_name) { should == last_name }
        its(:email) { should == email }
        its(:user_name) { should == user_name }
      end
    end

    context "when the  email parameters is not correct" do
      let!(:email){ "abc" }
      its(:code) { should == "400" }
      it { JSON.parse(response.body).should include "errors" }
    end

  end

  describe :login do
    let(:email){ "abc@gmail.com" }
    let(:user_name) { "abc" }
    let!(:user){ create(:user, email: email, user_name: "abc") }
    let(:post_params){
      { user: {
          email: email,
          user_name: user_name
      }}
    }

   let(:output) { post(:login, post_params) }

    subject { output }

    before {
      output
    }

    context "when credentials are correct" do
      it { should be_success }
    end

    context "when credentials are not correct" do
      let(:user_name) { "xyz" }
      it { should_not be_success}
    end

  end


end # RegistrationController


