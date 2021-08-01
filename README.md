# Share My Favs
## 概要
自分の好きなアーティストを5組選ぶことでオリジナルの画像を作成でき、Twitterでシェアすることができるサービスです。
![画像](https://user-images.githubusercontent.com/38002468/125733417-72ed0cab-0fd1-41e5-b23b-6f9988302126.png)
## URL
[Share my favs](https://my-fab-artists.herokuapp.com/myFavArtistLists)
## 使用技術
- Ruby 2.7.4
- Ruby on Rails 6.0.4
- MySQL(本番環境は5.5.62、docker環境では8.0を使用)
- JavaScript
- Tailwind CSS
- RSpec
- Git, GitHub
- Rubocop
- SpotifyAPI(wrapperのrspotify gemを使用)
- Heroku Container Registry
- Docker
- CircleCI(CI/CD)

## 機能一覧
- アーティストの検索(APIを使用)
- アーティストの追加(Ajax)
- アーティストの削除(Ajax)
- 画像の作成(minimagick)
- Twitterへのシェア
- OGPの作成
