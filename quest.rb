Critical_Coefficient = 1.5
Critical_Probability = 5
Miss_Probability = 10

class Mob
  attr_reader :name, :ap
  attr_accessor :hp
  def initialize(name:, max_hp:, ap:)
    @name = name
    @max_hp = max_hp
    @ap = ap
    @hp = @max_hp
  end

  def attack(target)
    puts "#{name}の攻撃！"
    return puts 'ミス！！！' if miss?
    if critical?
      puts 'クリティカルーーー！！！'
      critical_attack(target)
      damage = (ap * Critical_Coefficient).round
    else
      target.hp -= ap
      damage = ap
    end
    puts "#{target.name}に#{damage}のダメージ！"
  end

  private

  def critical?
    rand(Critical_Probability) == 1
  end

  def miss?
    rand(Miss_Probability) == 1
  end

  def critical_attack(target)
    target.hp -= (ap * Critical_Coefficient).round
  end
end

hero = Mob.new(name: '勇者', max_hp: 350, ap: 70)
satan = Mob.new(name: '魔王', max_hp: 400, ap: 60)

puts 'バトル開始！'
puts "#{hero.name} HP:#{hero.hp}, 攻撃力:#{hero.ap}"
puts "#{satan.name} HP:#{satan.hp}, 攻撃力:#{satan.ap}"
puts '================='

until (satan.hp <= 0 || hero.hp <= 0)
  hero.attack(satan)
  if satan.hp <= 0
    break puts "#{satan.name}を倒した！世界に平和が訪れた。"
  else
    puts "#{satan.name} HP:#{satan.hp}, 攻撃力:#{satan.ap}"
  end

  satan.attack(hero)
  if hero.hp <= 0
    break puts '勇者は倒れた・・・・・。'
  else
    puts "#{hero.name} HP:#{hero.hp}, 攻撃力:#{hero.ap}"
  end
  puts '================='
end
