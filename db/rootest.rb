require 'roo'
sheet = Roo::Spreadsheet.open('Data for App.xlsx')

puts sheet.sheet(0).row(1)
