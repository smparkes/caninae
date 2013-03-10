class Tollerdata::HomeController < Tollerdata::TollerdataController
  def show
    @search = Tollerdata::Search.new
  end
end
