# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Страницы пользователей >" do

  subject { page }

  describe "Страница регистрации >" do

    it "проверка заголовка" do
      visit signup_path
      should have_title('Helloworld - Регистрация')
    end
  end

  describe "Страница пользователя" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_title('Helloworld - ' + user.name) }
  end

  describe "Регистрация" do

    before { visit signup_path }

    let(:submit) { "Регистрация" }

    describe "с неправильными данными" do
      it "юзер не должен быть создан" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "с правильными даннми" do
      before do
        fill_in "Имя",         with: "Example User"
        fill_in "Почта",        with: "user@example.com"
        fill_in "Пароль",     with: "foobar"
        fill_in "Подтверждение пароля", with: "foobar"
      end

      it "юзер должен быть создан" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
