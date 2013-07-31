require 'spec_helper'

describe "Pages" do

  describe "Home page" do

    it "should have the content" do
      visit '/pages/home'
      page.should have_title('Helloworld - Home')
    end
  end
end
