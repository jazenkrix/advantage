get '/sandbox/:id' do
  @creature = Creature.find(params[:id])
  erb :statblock
end

get '/statblock_old/:id' do
  @creature = Creature.find(params[:id])
  erb :statblock_old, layout: false
end

# get '/monsters/process' do
#   @monsters = Monsters.new
#
#   @monsters.data.each do |monster|
#     @creature = Creature.find_or_create_by(name: monster[:name])

    # @creature.update(size: monster[:size],
    #                  category: monster[:type],
    #                  subtype: monster[:subtype],
    #                  alignment: monster[:alignment],
    #                  armor_class: monster[:armor_class],
    #                  hit_points: monster[:hit_points],
    #                  hit_dice: monster[:hit_dice],
    #                  speed: monster[:speed],
    #                  strength: monster[:strength],
    #                  dexterity: monster[:dexterity],
    #                  constitution: monster[:constitution],
    #                  intelligence: monster[:intelligence],
    #                  wisdom: monster[:wisdom],
    #                  charisma: monster[:charisma],
    #                  dmg_vulnerabilities: monster[:damage_vulnerabilities],
    #                  dmg_resistances: monster[:damage_resistances],
    #                  dmg_immunities: monster[:damage_immunities],
    #                  con_immunities: monster[:condition_resistances],
    #                  senses: monster[:senses],
    #                  languages: monster[:languages],
    #                  challenge_rating: monster[:challenge_rating],
    #                  monster: true)

    # saves = []
    # saves << "Str +#{monster[:strength_save]}" if monster[:strength_save] && monster[:strength_save] > 0
    # saves << "Dex +#{monster[:dexterity_save]}" if monster[:dexterity_save] && monster[:dexterity_save] > 0
    # saves << "Con +#{monster[:constitution_save]}" if monster[:constitution_save] && monster[:constitution_save] > 0
    # saves << "Int +#{monster[:intelligence_save]}" if monster[:intelligence_save] && monster[:intelligence_save] > 0
    # saves << "Wis +#{monster[:wisdom_save]}" if monster[:wisdom_save] && monster[:wisdom_save] > 0
    # saves << "Cha +#{monster[:charisma_save]}" if monster[:charisma_save] && monster[:charisma_save] > 0
    #
    # if saves.empty?
    #   @creature.update(saving_throws: "")
    # else
    #   @creature.update(saving_throws: saves.join(', '))
    # end
    #
    #
    # skills = []
    # skills << "Acrobatics +#{monster[:acrobatics]}" if monster[:acrobatics]
    # skills << "Athletics +#{monster[:athletics]}" if monster[:athletics]
    # skills << "Sleight of Hand +#{monster[:sleight_of_hand]}" if monster[:sleight_of_hand]
    # skills << "Stealth +#{monster[:stealth]}" if monster[:stealth]
    # skills << "Arcana +#{monster[:arcana]}" if monster[:arcana]
    # skills << "History +#{monster[:history]}" if monster[:history]
    # skills << "Investigation +#{monster[:investigation]}" if monster[:investigation]
    # skills << "Nature +#{monster[:nature]}" if monster[:nature]
    # skills << "Religion +#{monster[:religion]}" if monster[:religion]
    # skills << "Animal Handling +#{monster[:animal_handling]}" if monster[:animal_handling]
    # skills << "Insight +#{monster[:insight]}" if monster[:insight]
    # skills << "Medicine +#{monster[:medicine]}" if monster[:medicine]
    # skills << "Perception +#{monster[:perception]}" if monster[:perception]
    # skills << "Survival +#{monster[:survival]}" if monster[:survival]
    # skills << "Deception +#{monster[:deception]}" if monster[:deception]
    # skills << "Intimidation +#{monster[:intimidation]}" if monster[:intimidation]
    # skills << "Performance +#{monster[:performance]}" if monster[:performance]
    # skills << "Persuasion +#{monster[:persuasion]}" if monster[:persuasion]
    #
    # if skills.empty?
    #   @creature.update(skills: "")
    # else
    #   @creature.update(skills: skills.sort.join(', '))
    # end

    # if monster[:special_abilities]
    #   monster[:special_abilities].each do |ability|
    #     @ability = SpecialAbility.find_or_create_by(name: ability[:name], creature_id: @creature.id)
    #     @ability.update(desc: ability[:desc])
    #   end
    # end

    # if monster[:actions]
    #   monster[:actions].each do |action|
    #     @action = Action.find_or_create_by(name: action[:name], creature_id: @creature.id)
    #     @action.update(desc: action[:desc], action_type: '')
    #
    #     if action[:desc].start_with?('Melee') || action[:desc].start_with?('Ranged')
    #       @action.update(action_type: 'Attack')
    #       @action.update(to_hit: action[:attack_bonus]) if action[:attack_bonus]
    #
    #       damage_types = action[:desc].split(') ')
    #       type = 'unknown'
    #       type = damage_types[1].split(' ').first if damage_types.size == 2
    #       bonus_type = damage_types[2].split(' ').first if damage_types.size == 3
    #
    #       if action[:damage_dice] && action[:damage_dice].include?('+')
    #         normal = action[:damage_dice].split(' + ').first
    #         bonus = action[:damage_dice].split(' + ').last
    #         damage = "#{normal}+#{action[:damage_bonus]}/#{type}/#{bonus}/#{bonus_type}"
    #       elsif action[:damage_bonus] && action[:damage_bonus] > 0
    #         damage = "#{action[:damage_dice]}+#{action[:damage_bonus]}/#{type}"
    #       else
    #         damage = "#{action[:damage_dice]}/#{type}"
    #       end
    #
    #       @action.update(damage: damage)
    #
    #     end
    #   end
    # end

#     if monster[:legendary_actions]
#       monster[:legendary_actions].each do |action|
#         @action = Action.find_or_create_by(name: action[:name], creature_id: @creature.id)
#         @action.update(desc: action[:desc], action_type: 'Legendary')
#
#         if action[:desc].start_with?('Melee') || action[:desc].start_with?('Ranged')
#           @action.update(action_type: 'Attack')
#           @action.update(to_hit: action[:attack_bonus]) if action[:attack_bonus]
#
#           damage_types = action[:desc].split(') ')
#           type = 'unknown'
#           type = damage_types[1].split(' ').first if damage_types.size == 2
#           bonus_type = damage_types[2].split(' ').first if damage_types.size == 3
#
#           if action[:damage_dice] && action[:damage_dice].include?('+')
#             normal = action[:damage_dice].split(' + ').first
#             bonus = action[:damage_dice].split(' + ').last
#             damage = "#{normal}+#{action[:damage_bonus]}/#{type}/#{bonus}/#{bonus_type}"
#           elsif action[:damage_bonus] && action[:damage_bonus] > 0
#             damage = "#{action[:damage_dice]}+#{action[:damage_bonus]}/#{type}"
#           else
#             damage = "#{action[:damage_dice]}/#{type}"
#           end
#
#           @action.update(damage: damage)
#
#         end
#       end
#     end
#
#     if monster[:reactions]
#       monster[:reactions].each do |action|
#         @action = Action.find_or_create_by(name: action[:name], creature_id: @creature.id)
#         @action.update(desc: action[:desc], action_type: 'Reaction')
#
#         if action[:desc].start_with?('Melee') || action[:desc].start_with?('Ranged')
#           @action.update(action_type: 'Attack')
#           @action.update(to_hit: action[:attack_bonus]) if action[:attack_bonus]
#
#           damage_types = action[:desc].split(') ')
#           type = 'unknown'
#           type = damage_types[1].split(' ').first if damage_types.size == 2
#           bonus_type = damage_types[2].split(' ').first if damage_types.size == 3
#
#           if action[:damage_dice] && action[:damage_dice].include?('+')
#             normal = action[:damage_dice].split(' + ').first
#             bonus = action[:damage_dice].split(' + ').last
#             damage = "#{normal}+#{action[:damage_bonus]}/#{type}/#{bonus}/#{bonus_type}"
#           elsif action[:damage_bonus] && action[:damage_bonus] > 0
#             damage = "#{action[:damage_dice]}+#{action[:damage_bonus]}/#{type}"
#           else
#             damage = "#{action[:damage_dice]}/#{type}"
#           end
#
#           @action.update(damage: damage)
#
#         end
#       end
#     end
#   end
#   Creature.all.count.to_s
# end