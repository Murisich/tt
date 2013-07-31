# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Статические страницы >" do

  describe "Главная страница >" do

    it "проверка title" do
      visit root_path
      page.should have_title('Helloworld')
    end
  end
end
