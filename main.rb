require './facilitator'

HERO1 = { name: 'ゆうしゃ', max_hp: 200, atk: 50, mat: 10, agi: 50 }
HERO2 = { name: '魔法使い', max_hp: 100, atk: 20, mat: 50, agi: 40 }
HERO3 = { name: 'せんし', max_hp: 400, atk: 40, mat: 0, agi: 30 }

ENEMY1 = { name: 'スライム', max_hp: 10, atk: 10, mat: 0, agi: 10 }
ENEMY2 = { name: 'ドラゴン', max_hp: 250, atk: 30, mat: 90, agi: 60 }
ENEMY3 = { name: 'ゴーレム', max_hp: 400, atk: 70, mat: 0, agi: 20 }

heros = [HERO1, HERO2, HERO3]
enemies = [ENEMY1, ENEMY2, ENEMY3]

facilitator = Facilitator.new(heros, enemies)
facilitator.start
