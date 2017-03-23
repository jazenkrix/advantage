get '/sandbox/:id' do
  @creature = Creature.find(params[:id])
  erb :statblock
end

get '/monster/process' do
    @creature = Creature.find_or_create_by(name: 'Intellect Devourer')

    @creature.update(armor_class: '12',
                     hit_points: '21',
                     hit_dice: '6d4',
                     speed: '40 ft.',
                     strength: 6,
                     dexterity: 14,
                     constitution: 13,
                     intelligence: 12,
                     wisdom: 11,
                     charisma: 10,
                     saving_throws: '',
                     skills: 'Perception +2, Stealth +4',
                     dmg_vulnerabilities: '',
                     dmg_resistances: ' bludgeoning, piercing, and slashing from nonmagical attacks',
                     dmg_immunities: '',
                     con_immunities: 'blinded',
                     senses: 'blindsight 60 ft. (blind beyond this radius), passive Perception 12',
                     languages: "understands Deep Speech but can't speak, telepathy 60 ft.",
                     challenge_rating: '2',
                     monster: true)

    @special_ability = SpecialAbility.find_or_create_by(name: 'Detect Sentience', creature_id: @creature.id)
    @special_ability.update(desc: 'The intellect devourer can sense the presence and location of any creature within 300
                                  feet of it that has an Intelligence of 3 or higher, regardless of interposing barriers,
                                  unless the creature is protected by a <i>mind blank</i> spell.')

    @action = Action.find_or_create_by(name: 'Multiattack', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "The intellect devourer make one attack with its claws and uses Devour Intellect",
                   to_hit: nil,
                   damage: '')

    @action = Action.find_or_create_by(name: 'Claws', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "Melee Weapon Attack: +4 to hit, reach 5 ft., one target. Hit: 7 (2d4 + 2) slashing damage.",
                   to_hit: 4,
                   damage: '2d4+2/slashing')

    @action = Action.find_or_create_by(name: 'Devour Intellect', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "The intellect devourer targets one creature it can see within 10 feet of it that has a brain. The
                         target must succeed on a CD 12 INtelligence saving throw against this magic or take 11 (2d10) psychic
                         damage. Also on a failure, roll 3d6: If the total equals or exceeds the target's Intelligence score,
                         that score is reduced to 0. The target is stunned until it regains at least one point of Intelligence.",
                   to_hit: nil,
                   damage: '2d10/psychic')

    @action = Action.find_or_create_by(name: 'Body Thief', creature_id: @creature.id)
    @action.update(action_type: 'Attack',
                   desc: "The intellect devourer initiates an Intelligence contest with an incapacitated humanoid within
                         5 feet of it that isn't protected by <i>protection from evil and good</i>. If it wins the contest,
                         the intellect devourer magically consumes the target's brain, teleports into the skull, and take
                         control of the body. While there, the intellect devourer has total cover against attacks and other
                         effects originating outside its host. The intellect devourer retains its Intelligence, Wisdom,
                         and Charisma scores, as well as its understanding of Deep Speech, its telepathy, and its traits.
                         It otherwise adopts the target's statistics. It knows everything the creature knew, including
                         spells and languages.<br><br>If the host body dies, the intellect devourer must leave it. A
                         <i>protection from evil and good</i> spell cast on the body drives the intellect devourer out.
                         The intellect devourer is also forced out it the target regains its devoured brain by means of
                         a <i>wish<i>. By spending 5 feet of its movement, the intellect devourer can voluntarily leave
                         the body, teleporting to the nearest unoccupied space within 5 feet of it. The body then dies,
                         unless its brain is restored within 1 round.",
                   to_hit: nil,
                   damage: '2d10/psychic')
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