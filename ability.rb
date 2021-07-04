require 'pry'
class Ability
  attr_reader :name, :type, :mp_cost, :effect_amount
  TYPE = { magic_attack: 0, heal: 1}
  def initialize(name:, type:, mp_cost:, effect_amount:)
    @name = name
    @type = type if validate_type?(type)
    @mp_cost = mp_cost
    @effect_amount = effect_amount
  end

  def magic_attack?
    type == TYPE[:magic_attack]
  end

  def heal?
    type == TYPE[:heal]
  end

  private

  def validate_type?(type)
    raise 'アビリティタイプが不正' unless TYPE.value?(type)
    true
  end
end
