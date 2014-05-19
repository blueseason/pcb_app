# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    name     "王先生"
    email    "wangl@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
