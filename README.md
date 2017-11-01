# esa-daily-report

esa.ioの日報をWIPかどうか判別してSlackに通知するツールです。

# Setup
`.env.sample` をコピーして `.env` を作成して、以下の必要な設定項目を入力してください。

```
# esa.ioのユーザ名
USER_NAME=user_name
# esa.ioのチーム名
ESA_TEAM=team
# esa.ioのAPIで使うaccess token
ESA_ACCESS_TOKEN=token
# Slack Incoming WebhooksのURL
SLACK_WEBHOOK_URL=url
# 通知先のチャンネル
SLACK_CHANNEL=#channel
```

# Usage

```sh
$ docker-compose build
$ docker-compose up
```
