class GildedRose
  Aged_Brie = "Aged Brie"
  Backstage = "Backstage passes to a TAFKAL80ETC concert"
  Sulfuras = "Sulfuras, Hand of Ragnaros"
  def initialize(items)
    @items = items
  end

  #function to +/- quality value
  def update_quality_value(item, qvalue)
    if item.quality < 50
      item.quality = item.quality + qvalue
    end
  end

  #function to update backstage quality
  def update_backstage (item)
    if item.sell_in < 11 && item.sell_in > 5
      update_quality_value(item, 2)
    elsif item.sell_in < 6 && item.sell_in > 0
      update_quality_value(item, 3)
    elsif item.sell_in > 0
      update_quality_value(item, 1)
    end
  end

  def update_quality
    @items.each do |item|
      #Quality logic start
      if item.name != Sulfuras
        if item.name != Aged_Brie && item.name != Backstage
          if item.quality > 0
            update_quality_value(item, -1)
          end
        elsif item.name == Backstage
          update_backstage(item)
        else
          update_quality_value(item, 1)
        end
      end
      #Quality logic end

      #All item sell_in will decrease by 1 each day except for Sulfuras 
      if item.name != Sulfuras
        item.sell_in -= 1
      end
      #End item sell_in logic

      #When sell_in has passed, item start degrade
      if item.sell_in < 0
        if item.name == Aged_Brie
          update_quality_value(item, 1)
        elsif item.name == Backstage
          item.quality = item.quality - item.quality
        else
          if item.quality > 0
            if item.name != Sulfuras
              update_quality_value(item, -1)
            end
          end  
        end
      end
      #End for degrade logic

    end
  end
end
