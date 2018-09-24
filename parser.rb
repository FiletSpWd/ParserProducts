class Parser

    require 'rexml/document'
    include REXML
    require 'nokogiri'
    load '/home/filet/ParserProducts/site.rb'

    def initialize (siteforwork)
        @doc = Nokogiri::HTML( siteforwork.download_page )
        enimerable_links(parse_link)
    end

    def parse_link
        _links=[]

        @doc.xpath('//a[@class="product_img_link"]/@href').each do |row|
            _links.push(row.value)
        end
        return _links
    end

    def enimerable_links (array_links)
        array_links.each do |item|
            _page_product = Site.new(item)
            get_product(_page_product)
        end
    end

    def get_product (page_for_product)
        dom = Nokogiri::HTML(page_for_product.download_page)
        parse_items(dom)
    end



    def parse_first_name (doc_product)
        doc_product.xpath('//*[@class="product-name"]/h1').text
    end

    def parse_items (doc_product)
        items = []
        doc_product.xpath('//*[@class = "attribute_list"]/*' ).each do |row|
            tempName = row.search('span.attribute_name').text.strip
            tempPrice = row.search('span.attribute_price').text.strip
            check_empty_str(tempPrice, tempName, doc_product)
        end
    end

    def check_empty_str (price, name, doc_product)
        if !price.to_s.empty?
            item = Product.new(
                parse_first_name(doc_product) + name, 
                price, 
                parse_image(doc_product)
            )   
            item.write_product
        end
    end

    def parse_image (doc_product)
        return doc_product.xpath('//*[@class="img-responsive"]/@src')
    end
end