require 'pry'
require './facilitator'
require './unit'
require './ability'

hero1 = Unit.new(name: 'ゆうしゃ', max_hp: 200, atk: 50, mat: 10, agi: 50)
hero2 = Unit.new(name: '魔法使い', max_hp: 100, atk: 20, mat: 50, agi: 40)
hero3 = Unit.new(name: 'せんし', max_hp: 400, atk: 40, mat: 0, agi: 30)

enemy1 = Unit.new(name: 'スライム', max_hp: 10, atk: 10, mat: 0, agi: 10)
enemy2 = Unit.new(name: 'ドラゴン', max_hp: 250, atk: 30, mat: 90, agi: 60)
enemy3 = Unit.new(name: 'ゴーレム', max_hp: 400, atk: 70, mat: 0, agi: 20)

heros = [hero1, hero2, hero3]
enemies = [enemy1, enemy2, enemy3]

Facilitator.set(heros, enemies)
Facilitator.start
