require 'watir'
require 'json'
require 'nokogiri'
require_relative 'transaction.rb'
require_relative 'account.rb'
require_relative 'page_object.rb'


browser = Watir::Browser.new

browser.goto 'https://my.fibank.bg/EBank/'

browser.element(:xpath => "//span[@translate='LOGIN.DEMO']").click

name = browser.element(:xpath => "//div[@class='customer']/h5").text

tmp = browser.element(:xpath => "//p[@translate='PAGES.DASHBOARD_MAIN.AVL_CARD']/following-sibling::h4").text

currency = tmp.split(' ')[1]

balance = tmp.split(' ')[0]





sleep 5

browser.element(:xpath => "//a[@href='/EBank/accounts/statement/new']").click

site = Site.new(browser)

statement_page = site.statement_page

sleep 5

statement_page.iban_field.click

statement_page.iban_option("BG37FINV91501003939178  BGN").click 

puts Date.today.prev_month(2).strftime("%d/%m/%Y")

statement_page.from_date.set(Date.today.prev_month(2).strftime("%d/%m/%Y"))

statement_page.submit_button.click

sleep 5

html_code = browser.html

html_doc = Nokogiri::HTML(html_code)


transactions = []



table = html_doc.at("#accountStatements")

table.xpath('.//tbody/tr').each do |tr|
	transaction = Transaction.new(tr.xpath(".//td")[4].text, tr.xpath(".//td")[5].text.split(' ')[0], tr.xpath(".//td")[5].text.split(' ')[1], tr.xpath(".//td")[8].text, tr.xpath(".//td")[0].text)
	transactions << transaction
end

account = Account.new(name, currency, balance, transactions)

json_string = account.to_json

puts json_string





