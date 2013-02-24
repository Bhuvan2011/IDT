require 'spec_helper'

describe UserRole do

  describe :associations do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end # associations

  describe :validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:role) }
  end

  describe :factories do

    describe :user_role do
      subject { build(:user_role) }
      it { should be_valid }
    end

  end # factories

end
