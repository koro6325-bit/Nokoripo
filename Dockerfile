FROM ruby:3.2.2

# 必要な基本パッケージのインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs

# アプリケーションの配置ディレクトリ
RUN mkdir /nokoripo
WORKDIR /nokoripo

# 【最重要】新しくローカルにできた正確なGemfile群を、今度こそイメージ内に直接焼き込む
COPY Gemfile /nokoripo/Gemfile
COPY Gemfile.lock /nokoripo/Gemfile.lock

# ビルド時に bundle install を強制実行する
RUN bundle install

# 起動スクリプトのコピーと権限設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# サーバーの起動
CMD ["rails", "server", "-b", "0.0.0.0"]

