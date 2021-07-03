require 'pry'
CRITICAL_COEFFICIENT = 1.5
CRITICAL_PROBABILITY = 5
MISS_PROBABILITY = 10
MAGIC_ATTACK_PROBABILITY = 3

class Unit
  attr_reader :name, :atk, :mat, :agi, :abilities
  attr_accessor :hp, :mp
  def initialize(name:, max_hp:, max_mp:, atk:, mat:, agi:)
    @name = name
    @max_hp = max_hp
    @hp = @max_hp
    @max_mp = max_mp
    @mp = @max_mp
    @atk = atk
    @mat = mat
    @agi = agi
    @abilities = []
  end

  def attack(target)
    puts "#{name}の攻撃！"
    return puts 'ミス！！！' if miss?
    if mp > 0 && ability = selected_ability(sorted_abilities(abilities))
      magic_attack(target, ability)
    elsif critical?
      critical_attack(target)
    else
      physical_atk(target)
    end
  end

  def show_status
    "#{name} HP:#{hp}, MP:#{mp}, 攻撃力:#{atk}, 魔法攻撃力:#{mat}, 素早さ:#{agi}"
  end

  def learn(ability_list)
    @abilities = abilities | ability_list
  end

  private

  def miss?
    rand(MISS_PROBABILITY) == 1
  end

  def sorted_abilities(abilities)
    abilities.sort_by { |ability| ability.effect_amount }.reverse
  end

  def selected_ability(abilities)
    abilities.select { |ability| ability.mp_cost <= mp }.first
  end

  def magic_attack(target, ability)
    puts "★#{ability.name}を唱えた"
    damage_amount = ability.effect_amount
    self.mp -= ability.mp_cost
    damege(target, damage_amount)
  end

  def damege(target, damage_amount)
    target.hp -= damage_amount
    dameg_message(target, damage_amount)
  end

  def dameg_message(target, damage_amount)
    puts "#{target.name}に#{damage_amount}のダメージ！"
  end

  def critical?
    rand(CRITICAL_PROBABILITY) == 1
  end

  def critical_attack(target)
    puts 'クリティカルーーー！！！'
    damage_amount = (atk * CRITICAL_COEFFICIENT).round
    damege(target, damage_amount)
  end

  def physical_atk(target)
    damage_amount = atk
    damege(target, damage_amount)
  end
end
