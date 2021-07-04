require 'pry'
CRITICAL_COEFFICIENT = 1.5
CRITICAL_PROBABILITY = 5
MISS_PROBABILITY = 10
HEALING_PERCENTAGE = 0.5

class Unit
  attr_reader :name, :max_hp, :atk, :mat, :agi, :abilities
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
    if magic_attack?
      magic_attack(target)
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

  def heal_abilities
    abilities.select { |ability| ability.heal? && ability.mp_cost <= mp }
  end

  def damaged_amount
    max_hp - hp
  end

  def need_heal?
    alive? && hp <= max_hp * HEALING_PERCENTAGE
  end

  def heal(target)
    ability = select_healing_ability
    puts "♡回復♡#{name}は#{ability.name}を唱えた"
    heal_amount = ((target.hp + ability.effect_amount) > target.max_hp)? target.max_hp - target.hp : ability.effect_amount
    target.hp += heal_amount
    reduce_mp(ability)
    heal_message(target, heal_amount)
  end

  private

  def alive?
    hp > 0
  end

  def dead?
    !alive?
  end

  def miss?
    rand(MISS_PROBABILITY) == 1
  end

  def magic_attack?
    !magic_attack_abilities.empty? && mp > 0
  end

  def magic_attack_abilities
    abilities.select { |ability| ability.magic_attack? && ability.mp_cost <= mp }
  end

  def magic_attack(target)
    ability = select_magic_attack_ability
    puts "★魔法攻撃★#{name}は#{ability.name}を唱えた"
    damage_amount = ability.effect_amount
    reduce_mp(ability)
    damege(target, damage_amount)
  end

  def select_magic_attack_ability
    magic_attack_abilities.sort_by { |ability| ability.effect_amount }.reverse.first
  end

  def reduce_mp(ability)
    self.mp = ((mp - ability.mp_cost) < 0)? 0 : mp - ability.mp_cost
  end

  def damege(target, damage_amount)
    target.hp -= damage_amount
    dameg_message(target, damage_amount)
  end

  def dameg_message(target, damage_amount)
    puts "#{target.name}に#{damage_amount}のダメージ！"
  end

  def select_healing_ability
    heal_abilities.sort_by { |ability| ability.effect_amount }.reverse.first
  end

  def heal_message(target, heal_amount)
    puts "#{target.name}のHPを#{heal_amount}回復！"
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
