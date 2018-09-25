class Parser

    require 'rexml/document'
    include REXML
    require 'nokogiri'
    load 'site.rb'

    def initialize (siteforwork)
        @doc = Nokogiri::HTML(siteforwork.download_page)
        get_count_item
        set_pages
        multi_page_parse(siteforwork)
    end

    def multi_page_parse (siteforwork)
        for item in 1..@pages
            puts item
            puts (siteforwork.global_path)
            _page = Site.new("#{siteforwork.global_path}?p=#{item}")
            puts _page.global_path
            @doc = Nokogiri::HTML(_page.download_page)
            enimerable_links(parse_link)
        end
    end

    def set_pages
         if (@pages / 20.0)>(@pages / 20)
            @pages=@pages/20 + 1
         else
            @pages=@pages/20
         end
    end

    def get_count_item
        string = @doc.xpath('//small[@class="heading-counter"]')
        @pages  = /(\d+)/m.match(string.to_s)
        @pages = (@pages.to_s.to_i)
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
        doc_product.xpath('//*[@class="img-responsive"]/@src')
    end
end