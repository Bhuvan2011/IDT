FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) {|n| "#{n}#{Faker::Internet.email}" }

    user_name { Faker::Name.last_name}

    factory :unregistered_user do
      registration_status { :unregistered }
    end

  end
end
