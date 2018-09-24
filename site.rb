class Site
    require 'open-uri'

    def initialize (path)
        @global_path = path
    end

    def get_rpoduct_url 
        @tree_product.push("ggg")
    end

    def download_page 
        @page = open(@global_path)
    end


end