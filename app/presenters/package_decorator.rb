class PackageDecorator < SimpleDelegator



  def length
    return 20 unless total_count < 6
    total_count + 8
  end
  
  def width
    return 16 unless total_count < 6
    total_count + 6
  end

  def height
    return 12 unless total_count < 6
    total_count
  end

  def weight
    return 10 unless total_count < 6
    total_count
  end

end
