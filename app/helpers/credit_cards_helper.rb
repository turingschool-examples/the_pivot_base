module CreditCardsHelper
  def cc_years
    yrs = []
    year_today = Date.today.strftime("%y").to_i
    year_today.upto(year_today+10).each do |y| yrs << y.to_s;end
    return yrs
  end

  def cc_months
    ['01','02','03','04','05','06','07','08','09','10','11','12']
  end
end
