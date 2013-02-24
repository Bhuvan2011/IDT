require 'spec_helper'

describe UsersController do
  render_views

  describe :index do

    let(:output){ get(:index) }
    before { output }

    context "when there are users present" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }

      it "should return correct no of users" do
        assigns(:users){ should =~ [user1, user2]}
      end
    end

    context "when there are users present" do
      it "should return correct no of users" do
        assigns(:users){ should =~ []}
      end
    end

  end

   describe :create do

    let(:first_name) { 'New Firstname' }
    let(:last_name) { 'New Lastname' }
    let(:email) { 'new@gmail.com' }
    let(:user_name) { 'user_name' }
    let(:roles) { '' }

    let(:post_params) {
        { user: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        user_name: user_name,
        }, roles: roles }
      }

    let(:output) { post(:create, post_params) }

    subject { output }

    before {
      output
    }

    context "when roles are added to the user" do
      let(:roles) { "admin, user" }
      subject {assigns(:user)}
      its(:roles) { should be}
    end

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
    end

  end

end # RegistrationController


