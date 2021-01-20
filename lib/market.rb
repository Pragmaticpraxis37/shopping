class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    acc = []
    @vendors.each do |vendor|
      vendor.inventory.each do |inventory_item, amount|
        if item.name == inventory_item.name
          acc << vendor
        end
      end
    end
    acc
  end

  def total_inventory
    acc = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        if acc[item].nil?
          acc[item] = {quantity: 0, vendors: []}
        end

        acc[item][:quantity] += amount
        acc[item][:vendors] << vendor
      end
    end
    acc
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, item_data|
      if item_data[:vendors].length > 1 && item_data[:quantity] > 50
        overstocked_items << item
      end
    end
    overstocked_items
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        unless items.include?(item.name)
          items << item.name
        end
      end
    end
    items.sort
  end

  def sell(item_sell, quantity)
    total = 0
    total_inventory.each do |item, item_data|
      if item_sell == item
        total += item_data[:quantity]
      end
    end

    if total < quantity
      false
    else
      decrease_stock(item_sell, quantity)
      true
    end
  end

  def decrease_stock(item_sell, quantity)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, item_quantity|
        if item_sell == item
          if item_quantity >= quantity
            item_quantity -= quantity
          else
            require "pry"; binding.pry
          end
        end
      end
    end
  end
end
