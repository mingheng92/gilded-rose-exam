class GildedRose
  Aged_Brie = "Aged Brie"
  Backstage = "Backstage passes to a TAFKAL80ETC concert"
  Sulfuras = "Sulfuras, Hand of Ragnaros"
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      #Quality logic for normal item
      if item.name != Aged_Brie && item.name != Backstage
        if item.quality > 0
          if item.name != Sulfuras
            item.quality -= 1
          end
        end
      else

        #Quality logic for item Aged Brie, Backstage and Sulfuras
        if item.quality < 50
          item.quality += 1
          
          #Backstage item quality logic
          if item.name == Backstage
            if item.sell_in < 11
              if item.quality < 50
                item.quality += 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality += 1
              end
            end
          end
          #End of Backstage item quality logic

        end
        #End of Quality logic for item Aged Brie, Backstage and Sulfuras

      end
      #End of Quality logic for normal item
      

      #All item sell_in will decrease by 1 each day except for Sulfuras 
      if item.name != Sulfuras
        item.sell_in -= 1
      end
      #End item sell_in logic

      #When sell_in has passed, item start degrade
      if item.sell_in < 0
        if item.name == Aged_Brie
          if item.quality < 50
            item.quality += 1
          end
        elsif item.name == Backstage
          item.quality = item.quality - item.quality
        else
          if item.quality > 0
            if item.name != Sulfuras
              item.quality -= 1
            end
          end  
        end
      end
      #End for degrade logic

    end
  end
end
