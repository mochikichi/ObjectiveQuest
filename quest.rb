require 'pry'

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
  attr_reader :heros, :enemies
  def initialize(heros, enemies)
    @heros = set_units(heros)
    @enemies = set_units(enemies)
  end

  def start
    opening_message
    battle(heros, enemies)
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
    puts all_units.map(&:show_status)
    puts '================='
  end

  def all_units
    heros + enemies
  end

  def battle(offenses, defenses)
    while alive_anyone?
      offenses.each do |offense|
        defense = select_target(defenses)
        offense.attack(defense)
        if defense.hp <= 0
          defenses.delete(defense)
          puts "#{offense.name}は#{defense.name}をやっつけた！"
        end
        if wipe?(defenses)
          ending_message = heros?(offense) ? happy_end(offense, defense) : bad_end(offense, defense)
          return puts ending_message
        end
        puts all_units.map(&:show_status)
        puts '================='
      end
      offenses, defenses = change_turn(offenses, defenses)
    end
  end

  def alive_anyone?
    flg = false
    all_units.each {|unit| break flg = true if unit.hp > 0 }
    flg
  end

  def select_target(targets)
    target = targets.first
    if target.hp <= 0
      targets.delete(target)
      select_target(targets)
    end
    target
  end

  def heros?(unit)
    heros.include?(unit)
  end

  def wipe?(defenses)
    defenses.empty?
  end

  def happy_end(offense, defense)
    "#{offense.name}たちは#{defense.name}たちを倒した！。世界に平和が訪れた。"
  end

  def bad_end(offense, defense)
    "#{defense.name}たちは倒れた・・・。世界が闇に包まれた。"
  end

  def change_turn(offenses, defenses)
    [defenses, offenses]
  end
end

HERO1 = { name: 'ゆうしゃ', max_hp: 200, atk: 50, mat: 10 }
HERO2 = { name: '魔法使い', max_hp: 100, atk: 20, mat: 50 }
ENEMY1 = { name: 'スライム', max_hp: 10, atk: 10, mat: 0 }
ENEMY2 = { name: 'ドラゴン', max_hp: 300, atk: 50, mat: 90 }
# SATAN = { name: '魔王', max_hp: 400, atk: 60, mat: 70 }
heros = [HERO1, HERO2]
enemies = [ENEMY1, ENEMY2]

facilitator = Facilitator.new(heros, enemies)
facilitator.start
