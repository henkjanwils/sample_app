FactoryGirl.define do
  factory :user do
    name     "Anja Wils"
    email    "anja@coursegenerator.com"
    password "foobar"
    password_confirmation "foobar"
  end
end