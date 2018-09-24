load '/home/filet/ParserProducts/site.rb'
load '/home/filet/ParserProducts/product.rb'
load '/home/filet/ParserProducts/parser.rb'

st = Site.new("https://www.petsonic.com/hobbit-half/")
Product.filecsv = "myfile.csv"
parse = Parser.new(st)

