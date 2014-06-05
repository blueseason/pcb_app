# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:real_name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:mobile)  { |n| "138180000#{n+10}" }
    qq      "1234"
    #real_name "xxxx"
    address "real address"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

   factory :order  do
    length 30.35
    width  21.24
    user
  end
end
