class Admin::BannersController <  Admin::BaseController
  respond_to :html, :js

  def index
  	@banners= Banner.all
  end
end
