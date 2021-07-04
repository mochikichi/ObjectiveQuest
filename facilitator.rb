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
          if heal_action?(unit)
            healing_target = select_healing_target(healing_targets(unit))
            unit.heal(healing_target)
          else
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
          end
          puts units.map(&:show_status)
          puts '================='
        end
      end
    end

    def alive_anyone?
      !all_units.select { |unit| unit.alive? }.empty?
    end

    def sorted_units
      all_units.sort_by { |unit| unit.agi }.reverse
    end

    def select_target(targets)
      targets.select { |target| target.alive? }.shuffle.first
    end

    def heal_action?(unit)
      !unit.heal_abilities.empty? && !healing_targets(unit).empty?
    end

    def healing_targets(unit)
      targets = heros?(unit) ? heros : enemies
      targets.select { |target| target.need_heal? == true }
    end

    def select_healing_target(targets)
      targets.sort_by { |target| target.damaged_amount }.reverse.first
    end

    def heros?(unit)
      heros.include?(unit)
    end

    def wipe?(targets)
      targets.empty?
    end

    def happy_end(offense, defense)
      "#{offense.name}たちは#{defense.name}たちを倒した！。世界に平和が訪れた。"
    end

    def bad_end(offense, defense)
      "#{defense.name}たちは倒れた・・・。世界が闇に包まれた。"
    end
  end
end
