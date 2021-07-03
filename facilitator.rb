require 'pry'
class Facilitator

  class << self
    def set(heros, enemies)
      @heros = heros
      @enemies = enemies
    end

    def start
      opening_message
      battle
    end

    private

    def heros
      @heros
    end

    def enemies
      @enemies
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
end
