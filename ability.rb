class Ability
  attr_reader :name, :type, :mp_cost, :effect_amount
  def initialize(name:, type:, mp_cost:, effect_amount:)
    @name = name
    @type = type
    @mp_cost = mp_cost
    @effect_amount = effect_amount
  end
end
