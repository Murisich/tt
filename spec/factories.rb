# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    login     "Alex Sharipin"
    email    "murisich@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
