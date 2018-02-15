class Rate

  attr_reader :retail_rate

  def initialize(rate_hash)
    @retail_rate = rate_hash[:rates][2][:retail_rate]
    binding.pry
  end

end
