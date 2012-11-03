FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :address do
    name "Lastname"
    surname "surname"
    street "street"
    streetnumber 6
    town "town"
    link "link"
  end
end