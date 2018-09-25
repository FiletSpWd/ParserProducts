
load 'product.rb'
load 'parser.rb'
load 'site.rb'

st = Site.new("https://www.petsonic.com/hobbit-half/")
Product.filecsv = "myfile.csv"
parse = Parser.new(st)

