load '/home/filet/ParserProducts/site.rb'
load '/home/filet/ParserProducts/product.rb'
st = Site.new("url site")
st.download_page
pr = Product.new("123", "222", "rrrr")
pr.write_product