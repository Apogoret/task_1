
require 'nokogiri'

class BrowserContainer
    def initialize(browser)
      @browser = browser
    end
  end

  class Site < BrowserContainer
    def statement_page
      @statement_page = StatementPage.new(@browser)
    end

    def close
      @browser.close
    end
  end # Site

  class StatementPage < BrowserContainer

    def from_date
      @browser.at_xpath("//div[@name='FromDate']/input")
    end

    def submit_button

      @browser.at_xpath("//button[@translate='PAGES.ACCOUNT_STATEMENT.BUTTON']")
    end

    def statement_table
      @browser.at_xpath("//table[@id='accountStatements']")
    end
  end # StatementPage
