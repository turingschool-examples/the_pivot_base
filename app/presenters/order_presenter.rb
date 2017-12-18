class OrderPresenter
  
  def statuses
    Order.pluck(:status).uniq
  end

end
