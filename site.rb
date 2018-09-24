class Site
    require 'open-uri'

    def initialize (path)
        @global_path = path
    end

    def download_page 
        @page = open(@global_path)
    end


end