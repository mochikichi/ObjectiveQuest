require 'pry'
require './facilitator'
require './unit'
require './ability'

hero1 = Unit.new(name: 'ゆうしゃ', max_hp: 300, max_mp: 0, atk: 50, mat: 10, agi: 50)
hero2 = Unit.new(name: '魔法使い', max_hp: 150, max_mp: 30, atk: 20, mat: 50, agi: 40)
hero3 = Unit.new(name: 'せんし', max_hp: 350, max_mp: 0, atk: 40, mat: 0, agi: 30)

enemy1 = Unit.new(name: 'スライム', max_hp: 10, max_mp: 0, atk: 10, mat: 0, agi: 10)
enemy2 = Unit.new(name: 'ドラゴン', max_hp: 250, max_mp: 50, atk: 30, mat: 90, agi: 60)
enemy3 = Unit.new(name: 'ゴーレム', max_hp: 350, max_mp: 0, atk: 80, mat: 0, agi: 20)

magic1 = Ability.new(name: 'メラ', type: Ability::TYPE[:magic_attack] , mp_cost: 8, effect_amount: 50)
magic2 = Ability.new(name: 'メラゾーマ', type: Ability::TYPE[:magic_attack] , mp_cost: 18, effect_amount: 120)
heal1 = Ability.new(name: 'ホイミ', type: Ability::TYPE[:heal] , mp_cost: 8, effect_amount: 50)
heal2 = Ability.new(name: 'ベホイミ', type: Ability::TYPE[:heal] , mp_cost: 18, effect_amount: 120)

hero2.learn([magic1, heal1, heal2])
enemy2.learn([magic1, magic2, heal1])

heros = [hero1, hero2, hero3]
enemies = [enemy1, enemy2, enemy3]

Facilitator.set(heros, enemies)
Facilitator.start
