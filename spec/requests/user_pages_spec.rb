# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Страницы пользователей >" do

  describe "Страница регистрации >" do

    it "проверка заголовка" do
      visit signup_path
      page.should have_title('Helloworld - Регистрация')
    end
  end
end
