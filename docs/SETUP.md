# OpenAI News Summary セットアップガイド

このドキュメントでは、OpenAI News Summary を GitHub Actions で自動実行するための設定手順を説明します。

## 前提条件

以下のものが必要です。

- AWS アカウント (Amazon Bedrock へのアクセス権限)
- GitHub アカウント
- AWS CLI (ローカルでのデプロイ用)

## セットアップ手順

### 1. リポジトリの作成

```bash
# リポジトリをクローン
git clone https://github.com/YOUR_USERNAME/openai-news-summary.git
cd openai-news-summary
```

### 2. AWS IAM ロールの作成

GitHub Actions が AWS Bedrock にアクセスするための IAM ロールを作成します。

#### オプション A: CloudFormation を使用 (推奨)

```bash
# デプロイスクリプトを実行
chmod +x scripts/deploy-iam.sh
./scripts/deploy-iam.sh YOUR_GITHUB_ORG openai-news-summary
```

既存の OIDC プロバイダーがある場合は、ARN を指定できます。

```bash
./scripts/deploy-iam.sh YOUR_GITHUB_ORG openai-news-summary arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com
```

#### オプション B: AWS コンソールから手動作成

1. **OIDC プロバイダーの作成** (まだない場合)
   - IAM > Identity providers > Add provider
   - Provider type: OpenID Connect
   - Provider URL: `https://token.actions.githubusercontent.com`
   - Audience: `sts.amazonaws.com`

2. **IAM ロールの作成**
   - IAM > Roles > Create role
   - Web identity を選択
   - Identity provider: token.actions.githubusercontent.com
   - Audience: sts.amazonaws.com
   - 信頼ポリシーに以下を追加:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "Federated": "arn:aws:iam::YOUR_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
         },
         "Action": "sts:AssumeRoleWithWebIdentity",
         "Condition": {
           "StringEquals": {
             "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
           },
           "StringLike": {
             "token.actions.githubusercontent.com:sub": "repo:YOUR_GITHUB_ORG/openai-news-summary:*"
           }
         }
       }
     ]
   }
   ```

3. **Bedrock アクセス権限の付与**
   以下のポリシーをロールにアタッチします。

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "BedrockInvokeModel",
         "Effect": "Allow",
         "Action": [
           "bedrock:InvokeModel",
           "bedrock:InvokeModelWithResponseStream"
         ],
         "Resource": [
           "arn:aws:bedrock:*:*:inference-profile/global.anthropic.claude-*",
           "arn:aws:bedrock:*::foundation-model/anthropic.claude-*",
           "arn:aws:bedrock:*::foundation-model/us.anthropic.claude-*"
         ]
       }
     ]
   }
   ```

### 3. GitHub Secrets の設定

リポジトリの Settings > Secrets and variables > Actions で以下を設定します。

| Name | Value |
|------|-------|
| `AWS_ROLE_ARN` | 作成した IAM ロールの ARN |

### 4. GitHub Variables の設定 (オプション)

リポジトリの Settings > Secrets and variables > Actions > Variables で以下を設定できます。

| Name | Value | Default |
|------|-------|---------|
| `AWS_REGION` | AWS リージョン | `us-east-1` |
| `INFOGRAPHIC_BASE_URL` | インフォグラフィックの公開 URL | - |

### 5. GitHub Pages の有効化

1. Settings > Pages に移動
2. Source: GitHub Actions を選択
3. Save をクリック

### 6. 動作確認

1. Actions タブに移動
2. `OpenAI News Summary` ワークフローを選択
3. `Run workflow` をクリック
4. パラメータを設定して実行

## トラブルシューティング

### 認証エラー

```
Error: Could not assume role with OIDC
```

- IAM ロールの信頼ポリシーを確認
- リポジトリ名が正しいか確認
- OIDC プロバイダーが正しく設定されているか確認

### Bedrock エラー

```
Error: Access denied to Bedrock
```

- IAM ロールに Bedrock へのアクセス権限があるか確認
- リージョンで Claude モデルが利用可能か確認

### レート制限

```
Error: Rate limit exceeded
```

- `--days` パラメータを小さくして実行
- しばらく待ってから再実行

## ローカル実行

```bash
# 仮想環境の作成
python -m venv venv
source venv/bin/activate

# 依存関係のインストール
pip install -r requirements.txt

# AWS 認証情報の設定
export AWS_REGION=us-east-1
aws configure

# 実行
python run.py --days 3
```
