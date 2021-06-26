CRITICAL_COEFFICIENT = 1.5
CRITICAL_PROBABILITY = 5
MISS_PROBABILITY = 10
MAGIC_ATTACK_PROBABILITY = 3

class Mob
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

hero = Mob.new(name: '勇者', max_hp: 350, atk: 70, mat: 40)
satan = Mob.new(name: '魔王', max_hp: 400, atk: 60, mat: 70)

puts 'バトル開始！'
puts hero.show_status
puts satan.show_status
puts '================='

until (satan.hp <= 0 || hero.hp <= 0)
  hero.attack(satan)
  if satan.hp <= 0
    break puts "#{satan.name}を倒した！世界に平和が訪れた。"
  else
    puts satan.show_status
  end

  satan.attack(hero)
  if hero.hp <= 0
    break puts '勇者は倒れた・・・・・。'
  else
    puts hero.show_status
  end
  puts '================='
end
