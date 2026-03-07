# OpenAI News Summary

OpenAI の最新ニュースを自動収集し、日本語で詳細なレポートとインフォグラフィックを作成するツール。

## 機能

- OpenAI News/Blog、OpenAI API Changelog、OpenAI Research から最新情報を自動収集
- 日本語での詳細なレポート生成
- グラフィックレコーディング風インフォグラフィックの自動生成
- GitHub Actions による日次自動実行
- GitHub Pages での自動公開

## 情報ソース

| ソース | URL | 内容 |
|--------|-----|------|
| OpenAI News/Blog | https://openai.com/news | 公式発表、新機能、製品情報 |
| OpenAI API Changelog | https://platform.openai.com/docs/changelog | API 更新、新機能 |
| OpenAI Research | https://openai.com/research | 研究成果、論文 |

## セットアップ

CI/CD の詳細なセットアップ手順は [docs/SETUP.md](docs/SETUP.md) を参照してください。

### 必要条件

- Python 3.12+
- AWS アカウント (Amazon Bedrock アクセス権限)

### インストール

```bash
git clone https://github.com/YOUR_USERNAME/openai-news-summary.git
cd openai-news-summary
pip install -r requirements.txt
```

### AWS 認証情報の設定

```bash
export AWS_REGION=us-east-1
aws configure
```

## 使用方法

### 手動実行

```bash
# デフォルト (過去 3 日間)
python run.py

# 期間指定
python run.py --days 14
```

### GitHub Actions

リポジトリの Actions タブから `OpenAI News Summary` を手動実行できます。

## 出力

レポートは `reports/YYYY/YYYY-MM-DD-<slug>.md` 形式で保存されます。
インフォグラフィックは `infographic/YYYY-MM-DD-<slug>.html` 形式で保存されます。

## プロジェクト構造

```
openai-news-summary/
├── .github/
│   └── workflows/
│       └── openai-news-summary.yml
├── docs/
│   └── SETUP.md
├── scripts/
│   ├── deploy-iam.sh
│   └── cfn-github-oidc-iam.yaml
├── reports/
├── infographic/
├── run.py
└── requirements.txt
```

## ライセンス

MIT License
