class Item

  attr_reader :name,
              :price 

  def initialize(item_data)
    @name = item_data[:name]
    @price = item_data[:price].delete('$').to_f
  end

end
