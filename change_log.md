# Change_log

機能追加・改修の履歴を残す。
各versionのソースコードは、Tagsから'vx.x'を選択することで閲覧可能。

## v1.2

### Summary

- 一定確率（確率は固定値）でミスが発生する
- 一定確率（確率は固定値）でクリティカルダメージ（係数は固定値）が発生する

### Output_sample

- 乱数が使われるので同じ初期ステータス（HP,攻撃力）でも勝敗が変化する

- `output/output_v1.2_1.txt`
- `output/output_v1.2_1.txt`

## v1.1

### Summary

- 勇者と魔王が存在する
- 勇者と魔王はそれぞれHPと攻撃力というステータス（固定値）を持つ
- 勇者と魔王は相互に攻撃を繰り返す
- 攻撃力分、相手のHPを減らす
- どちらかのHPが0以下になった場合に終了

### Output_sample

固定値なので毎回同じ出力

- `output/output_v1.1.txt`