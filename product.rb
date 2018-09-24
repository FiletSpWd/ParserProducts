class Product

    def initialize (name, price, image)
        @name_product = name
        @price_product = price
        @image_product = image
    end

    def write_product
        puts @name_product (@price_product) - @image_product
    end
end