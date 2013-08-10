# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    name     "Alex Sharipin"
    email    "murisich@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
