# ブランチごとでschema.rbの整合性を保つために

## はまったミス

mainブランチからAブランチを切って、`rails db:migrate`をしたと仮定する。

1. Aブランチで`users`テーブルを追加
2. AブランチのPRを作成
3. mainブランチに戻る
4. mainブランチからBブランチを切る
5. Bブランチで`orders`テーブルを追加

BブランチにAブランチで作成したmigartionが`********** NO FILE **********`のようになって含まれてしまう。

また、`schema.rb`にもBブランチに無関係に思える`users`の情報が記載されている。

## 解決策

結論から言うと`rails db:rollback`を使えば良い

上記の例に最適解を適用すると以下の工程を踏めばいい

1. Aブランチで`users`テーブルを追加
2. AブランチのPRを作成
3. ↓↓↓ 答え ↓↓↓
4. Aブランチで`rails db:rollback`を実行し、`users`テーブルの作成を巻き戻す
5. mainブランチに戻る
6. mainブランチからBブランチを切る
7. Bブランチで`orders`テーブルを追加

ちなみに、rollbackするべきmigrationが複数ある場合は`rails db:rollback STEP=n`をすればOK

## rails db:migrate:resetじゃダメなの？？

結論：開発環境のデータを壊してもいいなら使ってもいいよって感じ
