# -*- encoding : utf-8 -*-
class TenantsController < AuthorizedController
  # Actions
  def current
    redirect_to current_user.tenant
  end
end
