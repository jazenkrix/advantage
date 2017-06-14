get '/ability/update' do
  SpecialAbility.update(302, desc: "The lich is an 18th-level spellcaster. Its spellcasting ability is Intelligence (spell save DC 20, +12 to hit with spell attacks). The lich has the following wizard spells prepared:<b><br>Cantrips (at will): <i>mage hand, prestidigitation, ray of frost</i><br> 1st level (4 slots): <i>detect magic, magic missile, shield, thunderwave</i><br> 2nd level (3 slots): <i>detect thoughts, invisibility, Melf's acid arrow, mirror image</i><br> 3rd level (3 slots): <i>animate dead, counterspell, dispel magic, fireball</i><br> 4th level (3 slots): <i>blight, dimension door</i><br> 5th level (3 slots): <i>cloudkill, scrying</i><br> 6th level (1 slot): <i>disintegrate, globe of invulnerability</i><br> 7th level (1 slot): <i>finger of death, plane shift</i><br> 8th level (1 slot): <i>dominate monster, power word stun</i><br> 9th level (1 slot): <i>power word kill</i>")
  redirect '/'
end

get '/sandbox/:id' do
  @creature = Creature.find(params[:id])
  erb :statblock
end

get '/monster/process' do
    @creature = Creature.find_or_create_by(name: 'Harshnag')

    @creature.update(armor_class: '21',
                     armor_type: '+3 plate',
                     hit_points: '204',
                     hit_dice: '12d12',
                     speed: '40 ft.',
                     strength: 23,
                     dexterity: 9,
                     constitution: 21,
                     intelligence: 9,
                     wisdom: 10,
                     charisma: 12,
                     saving_throws: 'Con +8, Wis +3, Cha +4',
                     skills: 'Athletics +9, Perception +3',
                     dmg_vulnerabilities: '',
                     dmg_resistances: '',
                     dmg_immunities: 'cold',
                     con_immunities: '',
                     senses: 'passive Perception 13',
                     languages: "Common, Giant",
                     challenge_rating: '9',
                     npc: true)

    @special_ability = SpecialAbility.find_or_create_by(name: 'Legendary Resistance', creature_id: @creature.id)
    @special_ability.update(desc: 'Once per day, when Harshnag fails a saving throw, he can choose to succeed instead.')

    @special_ability = SpecialAbility.find_or_create_by(name: 'Special Equipment', creature_id: @creature.id)
    @special_ability.update(desc: "Harshnag wears a suit of +3 plate armor and wields Gurt's greataxe.")

    @action = Action.find_or_create_by(name: 'Multiattack', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "Harshnag makes two Gurt's greataxe attacks.",
                   to_hit: nil,
                   damage: '')

    @action = Action.find_or_create_by(name: "Gurt's Greataxe", creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "Melee Weapon Attack: +11 to hit, reach 10 ft., one target. Hit: 26 (3d12 + 7) slashing damage.",
                   to_hit: 11,
                   damage: '3d12+7/slashing')

    @action = Action.find_or_create_by(name: "Gurt's Greataxe vs. Humans", creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "Melee Weapon Attack: +11 to hit, reach 10 ft., one target. Hit: 39 (5d12 + 7) slashing damage.",
                   to_hit: 11,
                   damage: '5d12+7/slashing')

    @action = Action.find_or_create_by(name: 'Rock', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "Ranged Weapon Attack: +9 to hit, Range 60/240 ft., one target. Hit: 28 (4d10 + 6) bludgeoning damage.",
                   to_hit: 9,
                   damage: '4d10+6/bludgeoning')

  erb :statblock
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