require 'spec_helper'

describe Role do

  describe :factory do

    describe :role do
      subject { build(:role) }
      it { should be_valid }
    end

  end

end
