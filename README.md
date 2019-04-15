# Jupyter Notebookでの技術書執筆環境

以下のような使い方を想定しています。

- `notebook`ディレクトリ以下に自由にnotebookを追加する
- notebookをpdf / htmlに変換する
- textlintを使って文字校正を行う
- dropboxに作成したpdfを配置してレビューをし合う
- gitlabにリポジトリを作成した場合はCIが走ってhtml版・pdf版が自動デプロイされる => DL,レビューしやすい


## notebookのpdf/htmlへのビルド

### 仮想環境でビルド

手元でpdf/htmlにビルドしたい場合は以下を実行します

```sh
docker-compose -f docker-compose.pdf.yml up make
```

`public/`以下にnotebookをpdfをhtmlで吐き出したものが保存されます。

### 自動ビルド 

リポジトリをgitlabに作成した場合、masterにpushすると自動でビルドが走り、pdf・html版が作成されます。  
以下のurlから確認とダウンロードができます。

`http://{グループ名}.gitlab.io/{リポジトリ名}/`

#### fumuumuf 版

gitlab pages は private リポジトリでも公開されてしまうので, デフォルトでは機能しないようにしています. 
この自動ビルドを使用する場合は

```console
cp exapmle.gitlab-ci.yml .gitlab-ci.yml
```

として, `.gitlab-ci.yml` を作成してください.


## Textlint

npmの[textlint](https://www.npmjs.com/package/textlint)を使って正しく文章がかかれているかチェックします。  
※lintをかけるために実行時にはnotebookを一度markdownに変換します。

```sh
docker build -t ipybook . && docker run -v `pwd`/public:/book/public: -it ipybook make textlint
```

### デフォルトで入れているルール

- `spellcheck-tech-word` 技術用語のチェック 
- `no-mix-dearu-desumasu` 「ですます」と「である」をミックスさせない
- `max-ten` 「、」を１文にn個以上出現させない: 

他のルールを追加は以下の手順で可能です。
- Dockerfileでルールをinstallする部分を追記
- `.textlintrc`にルールを追記

## 原稿の書き方

## notebookの置き場所

`notebook`以下に自由にnotebookを追加して書いてください。
※現在の環境では`notebook`以下にディレクトリを作成してその中にnotebookを配置するとビルドがうまく動きません。


### 画像の挿入
画像は`image`フォルダ以下に配置してください。    
`<img>`タグだとpdfに吐き出し出来ないため、notebook内では以下のようにmarkdown形式で画像を記載してください。

```
![画像test](../images/green.png)
```

## pdf2

上記までのオリジナルのものとは別に, `make pdf2` で PDF を出力できるようにしました.

オリジナルのものとは以下の違いがあります.

+ 画像は `notebook/image` ディレクトリに配置する (`image/`ではエラーとなる)
+ pdf 作成時に latex の関連ファイルが出力されない
+ デフォルトでは input セルは出力されない. 出力したい場合は `make pdf2 EXCLUDE_INPUT=True` を実行する

#### PDF出力

pdf2 での PDF 出力は次のコマンドを実行します.

```
docker-compose -f docker-compose.pdf.yml up pdf
```

成功すると, `public/pdf` 以下に PDF が出力されます.


## title と author

タイトルと著者は notebook の metadata の `title` と `authors` で設定できます.  

metadata は, メニューの **Edit > EditNotebook Metadata** から編集します.

```json
 "metadata": {
  "authors": [
   {
    "name": "著者A"
   }
  ],
  "title": "pdf のタイトル",

// ... その他の設定

 },
```
