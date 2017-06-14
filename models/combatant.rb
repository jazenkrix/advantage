class Combatant < ActiveRecord::Base

  belongs_to :encounter
  belongs_to :creature

end