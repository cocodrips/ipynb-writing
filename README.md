
## ビルド
masterにpushすると自動でビルドが走り、pdf・html版が作成されます。
以下から確認とダウンロードができます。

http://{グループ名}.gitlab.io/{リポジトリ名}/

### 仮想環境でのビルド

手元でpdf/htmlにビルドしたい場合は以下を実行します

```sh
docker build -t ipybook . && docker run -v `pwd`/public:/book/public: -it ipybook make
```

`public/`以下にnotebookをpdfをhtmlで吐き出したものが保存されます。

## Textlint

npmの[textlint](https://www.npmjs.com/package/textlint)を使って正しく文章がかかれているかチェックします。
※lintを書けるために実行時にはnotebookを一度markdownに変換しています。

```sh
docker build -t ipybook . && docker run -v `pwd`/public:/book/public: -it ipybook make textlint
```

### デフォルトで入れているルール

- 技術用語のチェック: spellcheck-tech-word
- 「ですます」と「である」をミックスさせない: no-mix-dearu-desumasu
- 「、」を１文にn個以上出現させない: max-ten

他のルールを追加は以下でできます。
- Dockerfileでルールをinstallする部分を追記
- `.textlintrc`にルールを追記

## 書き方
### 画像の挿入

`<img>`タグだとpdfに吐き出し出来ないので注意。notebook内では以下のように記載すること。

```
![画像test](../images/green.png)
```

