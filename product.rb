class Product
    require 'csv'
    @@filecsv

    def initialize (name, price, image)
        @name_product = name
        @price_product = price
        @image_product = image
    end

    def self.filecsv
        @@filecsv
    end

    def self.filecsv=(new_filecsv)
        @@filecsv = new_filecsv
    end

    def write_product
        CSV.open(@@filecsv, "ab") do |csv|
            csv << ["#@name_product", "#@price_product", "#@image_product"]
        end
    end
end