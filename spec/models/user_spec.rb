require 'spec_helper'

describe User do

  describe :fields do
    describe :first_name do
      let(:first_name) { 'Mary' }
      before { subject.first_name = first_name }
      its(:first_name) { should == first_name }
    end

    describe :last_name do
      let(:last_name) { 'Poppins' }
      before { subject.last_name = last_name }
      its(:last_name) { should == last_name }
    end

    describe :email do
      let(:email) { 'mary@poppins.com' }
      before { subject.email = email }
      its(:email) { should == email }
    end
  end # fields

  describe :associations do
    it { should have_many(:roles) }
  end # associations

  describe :properties do

    describe :valid_user_name? do
      let!(:user_name1){ "abc" }
      let!(:user_name2) { "xyz" }
      let!(:user) { create(:user, user_name: user_name1)}

      context "when the correct user name is passed" do
        subject { user.valid_user_name?(user_name1) }
        it { should ==  true}
      end

      context "when the incorrect user name is passed" do
        subject { user.valid_user_name?(user_name2) }
        it { should == false }
      end

    end

    describe :admin? do
      let(:roles) { raise ArgumentError }
      let(:user) { build(:user, roles: roles) }
      subject { user }

      context 'when user has no roles' do
        let(:roles) { [] }
        it { should_not be_admin }
      end

      context 'when user is an admin' do
        let(:roles) { [create(:role, name: 'admin')] }
        it { should be_admin }
      end

      context 'when user has role other than admin' do
        let(:roles) { [create(:role, name: 'manager')] }
        it { should_not be_admin }
      end

    end # admin?

  end # properties

end

