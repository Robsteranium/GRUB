module DateProcess

  def self.getNext(weekday = 4)    
    date = Time.now
    until (date.wday == weekday)
      date += 1.days
    end
    return date    
  end

  def self.getLast(weekday = 4)    
    date = Time.now
    until (date.wday == weekday)
      date -= 1.days
    end
    return date    
  end

  def self.nextThur
    self.getNext(4)
  end

  def self.nextFri
    self.getNext(5)
  end

  def self.nextDrop
    date = Time.now
    until (date.wday == 4 || date.wday == 5)
      date += 1.days
    end
    return date 
  end

  def self.lastDrop
    date = Time.now
    until (date.wday == 4 || date.wday == 5)
      date -= 1.days
    end
    return date 
  end

  def self.nearest(base_date, days, direction = 1)
    dates = []
    days.times do
      if base_date.wday == 4 || base_date.wday == 5
        dates << base_date
      end
      base_date += (direction).days
    end
    return dates
  end
  
  def self.next(days)
    self.nearest(self.nextDrop, days, 1)
  end
  
  def self.last(days)
    self.nearest(self.lastDrop, days, -1)
  end
  
end