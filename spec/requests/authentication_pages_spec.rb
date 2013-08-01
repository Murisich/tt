# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Авторизация >" do

  subject { page }

  describe "страница авторизации" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Авторизация') }
    it { should have_title('Helloworld - Авторизация') }
  end

  describe "процесс авторизации" do
    before { visit signin_path }

    describe "невалидная авторизация" do
      before { click_button "Войти" }

      it { should have_title('Helloworld - Авторизация') }
      it { should have_selector('div.alert.alert-error', text: 'Неверная почта/пароль') }
    end

    describe "валидная авторизация" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Почта", with: user.email.upcase
        fill_in "Пароль", with: user.password
        click_button "Войти"
      end

      it { should have_title('Helloworld - ' + user.name) }
      it { should have_link('Профиль', href: user_path(user)) }
      it { should have_link('Выйти', href: signout_path) }
      it { should_not have_link('Войти', href: signin_path) }
    end
  end
end
