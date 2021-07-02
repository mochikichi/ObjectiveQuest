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
