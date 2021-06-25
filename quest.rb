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
    target.hp -= ap
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
  puts "#{hero.name}の攻撃！　#{satan.name}に#{hero.ap}のダメージ！"
  if satan.hp <= 0
    break puts "#{satan.name}を倒した！世界に平和が訪れた。"
  else
    puts "#{hero.name} HP:#{hero.hp}, 攻撃力:#{hero.ap}"
  end

  satan.attack(hero)
  puts "#{satan.name}の攻撃！　#{hero.name}に#{satan.ap}のダメージ！"
  if hero.hp <= 0
    break puts '勇者は倒れた・・・・・。'
  else
    puts "#{satan.name} HP:#{satan.hp}, 攻撃力:#{satan.ap}"
  end
  puts '================='
end
