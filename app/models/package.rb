class Package
  attr_reader :count

  def initialize(cart)
    @count = cart.contents.count
  end

  def length
    return 20 unless count < 6
    count + 8
  end
  def width
    return 16 unless count < 6
    count + 6
  end
  def height
    return 12 unless count < 6
    count
  end
  def weight
    return 10 unless count < 6
    count
  end

end
