require 'roo'


sheet = Roo::Spreadsheet.open('Data-for-App.xlsx')

puts sheet.sheet(0)
row=2
max_row=391



File.open("bookseeds.txt", 'w') do |file| 
while row < max_row
	#user = User.search_by_name(sheet.sheet(0).cell(row,3)).first.id unless User.search_by_name(sheet.sheet(0).cell(row,3)).first.nil?
	file.write("{book_id: #{sheet.sheet(0).cell(row,1)}, owner_id: '#{sheet.sheet(0).cell(row,2)}' , group: '#{sheet.sheet(0).cell(row,3)}', name: '#{sheet.sheet(0).cell(row,4)}', author: '#{sheet.sheet(0).cell(row,5)}', category_id: #{sheet.sheet(0).cell(row,7)}, num_of_pages: #{sheet.sheet(0).cell(row,11)}, page_size: '#{sheet.sheet(0).cell(row,12)}', publishing_house: '#{sheet.sheet(0).cell(row,14)} #{sheet.sheet(0).cell(row,15)} #{sheet.sheet(0).cell(row,16)}'},") 
	row += 1
  end
end