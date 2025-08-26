# SideGallery

<h3>SideGalleryは、巡り会えた素敵な美術作品を共有するサービスです</h3>

[<img src="docs/images/sidegallery_top.png" alt="sidegallery_top" width="600">](docs/images/sidegallery_top.png)
<br><br>

# サービスURL
[https://sidegallery.herokuapp.com/](https://mb-myportfolio-898f86d4fd9e.herokuapp.com/)
<br><br>

## 1. SideGalleryの概要

SideGalleryは、
観光中に偶然見つけた脇道や路地裏のような、本筋とは異なる場所で巡り会えた作品との出会いをコンセプトに制作されたサービスです。

SideGalleryでは、アメリカのメトロポリタン美術館の膨大な所蔵作品からAPIにより作品画像を取得しております。

そして、著名な作品は元より、普段なら検索することもないような作品にも１つ１つ均等に鑑賞できるスペースを設けております。

その中から出会った印象的な作品は、コメントをつけて投稿し、他のユーザや閲覧者に共有できるのが特徴です。
<br><br>

## 2. 開発の背景

APIを使用したアプリのアイデアを考えていた時に、メトロポリタン美術館が所蔵作品をAPIとして公開していることを知りました。

私は美術館に行くのが好きなこともあり、また、このAPIを使用したアプリも見られなかったことから、アプリの開発にこのAPIを使用することに決めました。

そして、脇道に入ったような少し秘密な場所で、美術の好きな人や興味のある人が、メトロポリタン美術館の膨大な所蔵作品の中からたまたま出会った印象的な作品を共有し合う楽しみの場を作りたいと考えたため、本アプリを開発しました。
<br><br>

## 3. 利用の仕方
|　トップページ	|　ヘッダー　|
| ---- | ---- |
| [<img src="docs/images/use/top_page.jpg" alt="top_page" width="300">](docs/images/use/top_page.jpg) | [<img src="docs/images/use/header.jpg" alt="header" width="300">](docs/images/use/header.jpg) |
| トップページではセレクトボックスから、<br>鑑賞したい作品のジャンルを指定して<br>鑑賞ボタンを押すと鑑賞ページに遷移できます。<br><br>新着投稿の欄にはユーザが投稿した作品が<br>掲載されております。<br><br>もっと見るボタンを押すと、<br>投稿一覧画面に遷移します。 | ヘッダーでは投稿一覧、鑑賞リンクをはじめ、<br>新規登録やログインボタンを用意しております。<br><br>ゲストログイン機能により、<br>新規登録せずにサービスを利用することもできます。<br><br>ログインすると、これらのボタンはユーザー欄に変わり、<br>クリックするとマイページ等のメニューが表示されます。 |

|　鑑賞ページ	|　新規投稿　|
| ---- | ---- |
| [<img src="docs/images/use/department.jpg" alt="department" width="300">](docs/images/use/department.jpg) | [<img src="docs/images/use/new_post.jpg" alt="new_post" width="300">](docs/images/use/new_post.jpg) |
| 鑑賞ページでは、<br>メトロポリタン美術館の所蔵作品のうち、<br>指定したジャンルから9枚の作品が<br>無作為に選ばれて表示されます。<br>各作品は画像をクリックすると<br>より大きな画像を表示できます。<br><br>作品の説明欄では、 ![icon_met](./docs/images/icons/met.jpg)をクリックすると<br>メトロポリタン美術館の外部リンクで<br>作品の詳細を見ることができます。<br><br>気に入った作品は「この作品を投稿」を<br>クリックすると、新規投稿に遷移します。| 新規投稿では、気に入った作品にコメントをつけて<br>投稿することができます。<br>その作品の好きなところや、<br>良いと思うところを是非書いて投稿しましょう。 |

|　投稿一覧	|　マイページ　|
| ---- | ---- |
| [<img src="docs/images/use/index.jpg" alt="index" width="300">](docs/images/use/index.jpg) | [<img src="docs/images/use/mypage.jpg" alt="mypage" width="300">](docs/images/use/mypage.jpg) |
| 投稿一覧では、<br>投稿者や作品のジャンルを選択して<br>投稿内容を検索することができます。<br><br>投稿のユーザ欄をクリックすると、<br>そのユーザのマイページに遷移します。<br><br>気に入った投稿は![icon_favorite](./docs/images/icons/favorite.jpg)を押して<br>いいねをすることが可能です。<br><br>自ユーザの投稿には、<br>編集と削除ボタンが表示され<br>投稿の編集や削除ができます。 | マイページでは、そのユーザの投稿数、いいね数、<br>いいねされた数が表示されます。<br><br>また、そのユーザの投稿内容や<br>いいねした投稿を見ることもできます。<br><br>マイページでは自ユーザのページに限り、<br>ユーザの設定ボタンが表示されます。<br>(ゲストの場合は表示されません。) |

## 4. 機能まとめ

* ユーザ新規登録(devise使用)
* ログイン(devise使用)
* ゲストログイン
<br><br>
* 投稿一覧
  * 検索機能(ransack使用)
    * 投稿者・ジャンル指定
* ユーザごとの投稿一覧・いいね一覧
<br><br>
* 作品の鑑賞
  * ジャンル選択セレクトボックス
  * 作品の画像・タイトル・制作者・ジャンル
  * メトロポリタン美術館の外部リンク
  * 作品の投稿
<br><br>


## 5. 使用技術

|　カテゴリー	|　使用技術　|
| ---- | ---- |
| フロントエンド | HTML・CSS・Javascript<br>Bootstrap(一部UIフレームワーク) |
| バックエンド | Ruby 3.3.3<br>Ruby on Rails 6.1.3.2 |
| データベース | PostgreSQL |
| インフラ | Heroku(デプロイ)<br>AWS(ユーザアイコンのストレージ)|
| 開発環境 / 開発ツール | Git / GitHub(バージョンの管理)<br>RSpec(テストのフレームワーク)<br>SimpleCov（テストカバレッジ計測）<br>Rubocop(コードの静的解析)<br>Bullet（N+1クエリの検出） |
| CI/CD | CircleCI<br>（RSpec・Rubocopの自動実行、Herokuへの自動デプロイ） |
| API | The Metropolitan Museum of Art Collection API |

## 6. ER図

以下は、本サービスのER図になります。<br>
Userモデルは、ActiveStorageによるアイコン画像機能を有しております。<br>
MetObjectモデルにはAPIにより取得された作品データが格納されており、<br>
鑑賞ページで表示される作品を基にPostモデルによる投稿を行うことができます。<br>
気に入った投稿は、Favoriteモデルによりいいねをすることができます。

[<img src="docs/images/ER.png" alt="ER図" width="600">](docs/images/ER.png)
<br><br>

## 7. テスト
テストはmodel specによる単体テスト、request specによる結合テストを実施しており、<br>
simplecovによるカバレッジ計測100%を達成しております。(下画像参照)<br>
また、カバレッジの達成に加えて、<br>
未ログイン時やゲストログイン時のアクセス制限や一部機能の制限などは<br>網羅的な検証を行っております。<br>
その他、カバレッジの計測対象外となっている、<br>動的に生成されるHTMLの要素が正しく含まれていることの検証も合わせて行っております。

[<img src="docs/images/coverage_result.png" alt="coverage_result" width="600">](docs/images/coverage_result.png)
<br><br>

## 8. 今後の展望

以下の内容を目標としております。

* google認証機能の実装
* 投稿の並び替え機能の実装(投稿日時順・いいね順)
* ユーザフォロー機能の実装
* 取り扱うジャンルの拡大
* system_specの実装

