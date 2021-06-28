require 'pry'

CRITICAL_COEFFICIENT = 1.5
CRITICAL_PROBABILITY = 5
MISS_PROBABILITY = 10
MAGIC_ATTACK_PROBABILITY = 3

class Unit
  attr_reader :name, :atk, :mat, :agi
  attr_accessor :hp
  def initialize(name:, max_hp:, atk:, mat:, agi:)
    @name = name
    @max_hp = max_hp
    @hp = @max_hp
    @atk = atk
    @mat = mat
    @agi = agi
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
    "#{name} HP:#{hp}, 攻撃力:#{atk}, 魔法攻撃力:#{mat}, 素早さ:#{agi}"
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
    battle
  end

  private

  def set_units(units_infos)
    units = []
    units_infos.each do |info|
      units << Unit.new(name: info[:name], max_hp: info[:max_hp], atk: info[:atk], mat: info[:mat], agi: info[:agi])
    end
    units
  end

  def opening_message
    puts 'バトル開始！'
    puts sorted_units.map(&:show_status)
    puts '================='
  end

  def all_units
    heros + enemies
  end

  def battle
    while alive_anyone?
      units = sorted_units
      units.each do |unit|
        targets = heros?(unit) ? enemies : heros
        target = select_target(targets)
        unit.attack(target)
        if target.hp <= 0
          units.delete(target)
          targets.delete(target)
          puts "#{unit.name}は#{target.name}をやっつけた！"
        end
        if wipe?(targets)
          ending_message = heros?(unit) ? happy_end(unit, target) : bad_end(unit, target)
          return puts ending_message
        end
        puts units.map(&:show_status)
        puts '================='
      end
    end
  end

  def alive_anyone?
    flg = false
    all_units.each {|unit| break flg = true if unit.hp > 0 }
    flg
  end

  def sorted_units
    all_units.sort_by { |unit| unit.agi }.reverse
  end

  def select_target(targets)
    target = targets.shuffle.first
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

HERO1 = { name: 'ゆうしゃ', max_hp: 200, atk: 50, mat: 10, agi: 50 }
HERO2 = { name: '魔法使い', max_hp: 100, atk: 20, mat: 50, agi: 40 }
HERO3 = { name: 'せんし', max_hp: 400, atk: 40, mat: 0, agi: 30 }

ENEMY1 = { name: 'スライム', max_hp: 10, atk: 10, mat: 0, agi: 10 }
ENEMY2 = { name: 'ドラゴン', max_hp: 250, atk: 30, mat: 90, agi: 60 }
ENEMY3 = { name: 'ゴーレム', max_hp: 400, atk: 70, mat: 0, agi: 20 }

heros = [HERO1, HERO2, HERO3]
enemies = [ENEMY1, ENEMY2, ENEMY3]

facilitator = Facilitator.new(heros, enemies)
facilitator.start
