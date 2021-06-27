CRITICAL_COEFFICIENT = 1.5
CRITICAL_PROBABILITY = 5
MISS_PROBABILITY = 10
MAGIC_ATTACK_PROBABILITY = 3

class Unit
  attr_reader :name, :atk, :mat
  attr_accessor :hp
  def initialize(name:, max_hp:, atk:, mat:)
    @name = name
    @max_hp = max_hp
    @hp = @max_hp
    @atk = atk
    @mat = mat
  end

  def attack(target)
    puts "#{name}の攻撃！"
    return puts 'ミス！！！' if miss?
    if magic_attack?
      puts '★魔法攻撃！'
      target.hp -= mat
      damage = mat
    elsif critical?
      puts 'クリティカルーーー！！！'
      critical_attack(target)
      damage = (atk * CRITICAL_COEFFICIENT).round
    else
      target.hp -= atk
      damage = atk
    end
    puts "#{target.name}に#{damage}のダメージ！"
  end

  def show_status
    "#{name} HP:#{hp}, 攻撃力:#{atk}, 魔法攻撃力:#{mat}"
  end

  private

  def critical?
    rand(CRITICAL_PROBABILITY) == 1
  end

  def miss?
    rand(MISS_PROBABILITY) == 1
  end

  def magic_attack?
    rand(MAGIC_ATTACK_PROBABILITY) == 1
  end

  def critical_attack(target)
    target.hp -= (atk * CRITICAL_COEFFICIENT).round
  end
end

class Facilitator
  attr_reader :units
  def initialize(units_infos)
    @units = set_units(units_infos)
  end

  def start
    opening_message
    offense, defense = units
    battle(offense, defense)
  end

  private

  def set_units(units_infos)
    units = []
    units_infos.each do |info|
      units << Unit.new(name: info[:name], max_hp: info[:max_hp], atk: info[:atk], mat: info[:mat])
    end
    units
  end

  def opening_message
    puts 'バトル開始！'
    puts units.map(&:show_status)
    puts '================='
  end

  def battle(offense, defense)
    while alive_anyone?
      offense.attack(defense)
      if defense.hp <= 0
        ending_message = (offense.name == '勇者') ? happy_end(offense, defense) : bad_end(offense, defense)
        break puts ending_message
      else
        puts defense.show_status
      end
      puts '================='
      offense, defense = change_turn(offense, defense)
    end
  end

  def alive_anyone?
    flg = false
    units.each {|unit| break flg = true if unit.hp > 0 }
    flg
  end

  def change_turn(offense, defense)
    [defense, offense]
  end

  def happy_end(offense, defense)
    "#{offense.name}は#{defense.name}を倒した！。世界に平和が訪れた。"
  end

  def bad_end(offense, defense)
    "#{defense.name}は倒れた・・・。世界が闇に包まれた。"
  end
end

HERO = { name: '勇者', max_hp: 350, atk: 70, mat: 40 }
SATAN = { name: '魔王', max_hp: 400, atk: 60, mat: 70 }
units_infos = [HERO, SATAN]

facilitator = Facilitator.new(units_infos)
facilitator.start
