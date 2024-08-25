FROM ruby:3.2.4

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client curl && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# 作業ディレクトリを設定
WORKDIR /myapp

# Rubyの依存関係をインストール
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Node.jsの依存関係をインストールし、webpackを実行
COPY package.json yarn.lock ./
RUN yarn install

# 環境変数を設定
ENV NODE_OPTIONS=--openssl-legacy-provider

# アプリケーションのソースコードをコピー
COPY . .

# 環境変数を設定してビルド
RUN NODE_OPTIONS=--openssl-legacy-provider yarn run build


# ポートを公開
EXPOSE 3000

# コンテナが起動するコマンド
CMD ["rails", "server", "-b", "0.0.0.0"]