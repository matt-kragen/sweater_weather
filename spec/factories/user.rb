FactoryBot.define do
  factory :user do
    email { "test@test.com" }
    password { 'fhtagn'}
    password_confirmation { 'fhtagn'}
    api_key { "thisisyourapikey" }
  end
end