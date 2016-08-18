# feed2jsonsql
CiNii Articles から opensearch で検索したデータをjsonにして、jsonsqlで手軽に検索する。

## How to
* Clone repository or "zip" downloads
* click jsonsql_UI.html (any browser)
* とりあえず、「図書館雑誌」のデータが検索できます。

## Usage
* jsonデータの作り方
** feedjiratest.rb のkeyword等を適宜修正の上、以下を実行
** ruby feedjiratest.rb > feedtest5.json

## Feature
* とりあえず、キーワード一つしか検索できませんが、sqlで調整は可能です。