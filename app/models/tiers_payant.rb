# -*- encoding : utf-8 -*-
class TiersPayant < Tiers
  belongs_to :guarantor, :class_name => 'Insurance'
  
  # TODO: check with spec
  def intermediate
    insurance
  end

  def recipient
    insurance.group
  end
end
