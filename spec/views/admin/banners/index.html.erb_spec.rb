require 'rails_helper'
before_action :find_tag, only: [:update, :destroy]

  respond_to :html, :js

end
