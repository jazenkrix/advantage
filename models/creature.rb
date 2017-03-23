class Creature < ActiveRecord::Base

  has_many :special_abilities
  has_many :actions

  def creature_type
    if self.subtype.size > 0
      "#{self.category.downcase} (#{self.subtype.downcase})"
    else
      "#{self.category.downcase}"
    end
  end

  def subhead
    "#{self.size.capitalize} #{self.creature_type.downcase}, #{self.alignment}"
  end

  def health
    "#{self.hit_dice} + #{((self.constitution - 10)/2) * self.hit_dice.split('d').first.to_i}"
  end

  def base_speed
    self.speed.split(', ').first
  end

  def movements
    self.speed.split(', ')[1..-1].join(', ')
  end

  def legendary_actions
    self.actions.where(action_type: 'Legendary')
  end

  def reactions
    self.actions.where(action_type: 'Reaction')
  end

  def has_special_attributes?
    result = "#{self.dmg_vulnerabilities} #{self.dmg_resistances} #{self.dmg_immunities} #{self.con_immunities}"
    result.empty?
  end

end