---
name: openai-news-summary
description: OpenAI の最新ニュース (OpenAI News/Blog、OpenAI API Changelog、OpenAI Research) を取得し、日本語で詳細な解説レポートを作成するスキル。ユーザーが「OpenAI ニュース」「GPT アップデート」「OpenAI API 変更」「ChatGPT 更新」などと言った場合に使用する。
---

# OpenAI News Reporter Skill <!-- omit in toc -->

## 目次

- [目次](#目次)
- [情報ソース](#情報ソース)
- [ワークフロー](#ワークフロー)
  - [0. 現在時刻の確認](#0-現在時刻の確認)
  - [1. ニュースソースから最新情報を取得](#1-ニュースソースから最新情報を取得)
  - [2. 期間フィルタリング (デフォルト: 過去 7 日間)](#2-期間フィルタリングデフォルト-過去-7-日間)
  - [3. 重複チェック](#3-重複チェック)
  - [4. 詳細情報の取得](#4-詳細情報の取得)
  - [5. レポート作成](#5-レポート作成)
  - [6. アーキテクチャ図の作成 (必要に応じて)](#6-アーキテクチャ図の作成必要に応じて)
- [出力形式](#出力形式)
- [実行例](#実行例)
- [注意事項](#注意事項)


OpenAI News/Blog、OpenAI API Changelog、OpenAI Research から最新情報を取得し、構造化されたレポートを作成する。

## 情報ソース

1. **OpenAI News/Blog**: https://openai.com/news
   - 公式発表、新機能、製品情報
   - HTML ページをパースして取得

2. **OpenAI API Changelog**: https://platform.openai.com/docs/changelog
   - OpenAI API の更新情報
   - Chat Completions API、SDK、新機能など

3. **OpenAI Research**: https://openai.com/research
   - 研究成果、論文
   - 技術的な詳細情報

## ワークフロー

### 0. 現在時刻の確認

**重要**: 作業を開始する前に、必ず現在時刻を確認する。

```bash
date "+%Y-%m-%d %H:%M:%S %Z"
```

### 1. ニュースソースから最新情報を取得

**重要**: 各ソースは**1 回だけ**取得する。複数回リクエストしない。

#### OpenAI News/Blog の取得

**WebFetch ツールを使用**:

```
WebFetch を使用して https://openai.com/news から最新ニュースを取得。
プロンプト: "最新のニュース記事を20件、以下の形式でJSON配列として抽出:
[{\"title\": \"タイトル\", \"date\": \"YYYY-MM-DD\", \"link\": \"URL\", \"description\": \"説明\"}]"
```

#### OpenAI API Changelog の取得

**WebFetch ツールを使用**:

```
WebFetch を使用して https://platform.openai.com/docs/changelog から取得。
プロンプト: "過去30日間のリリースノートを日付ごとに抽出。
各エントリは {\"date\": \"YYYY-MM-DD\", \"items\": [\"変更内容1\", \"変更内容2\"]} 形式で。"
```

#### OpenAI Research の取得

**WebFetch ツールを使用**:

```
WebFetch を使用して https://openai.com/research から取得。
プロンプト: "最新の研究記事を10件、以下の形式でJSON配列として抽出:
[{\"title\": \"タイトル\", \"date\": \"YYYY-MM-DD\", \"link\": \"URL\", \"description\": \"説明\"}]"
```

### 2. 期間フィルタリング (デフォルト: 過去 7 日間)

取得したニュースアイテムを日付でフィルタリングする。

### 3. 重複チェック

既存のレポートと重複しないか確認する。

```bash
# 既存レポートのリストを取得
ls reports/*/
```

出力ファイル名は `YYYY-MM-DD-<slug>.md` 形式。同じ日付とスラッグの組み合わせが存在する場合はスキップ。

### 4. 詳細情報の取得

各ニュースアイテムについて、詳細ページから追加情報を取得する。

#### OpenAI News の詳細

**WebFetch ツールを使用**:

```
WebFetch を使用して詳細ページを取得。
プロンプト: "記事の全文と関連情報を抽出。"
```

### 5. レポート作成

以下のテンプレートに従ってレポートを作成する。

**ファイル名規則**: `reports/YYYY/YYYY-MM-DD-<slug>.md`

- `YYYY`: 年
- `MM-DD`: 月日
- `slug`: タイトルから生成した URL フレンドリーな文字列

**レポートテンプレート**: `report_template.md` を参照

### 6. アーキテクチャ図の作成 (必要に応じて)

技術的な内容の場合、Mermaid 形式でアーキテクチャ図を追加する。

```mermaid
flowchart TD
    subgraph Client["Client Application"]
        SDK["OpenAI SDK"]
    end

    subgraph API["OpenAI API"]
        Chat["Chat Completions"]
        Assistants["Assistants API"]
    end

    SDK --> Chat
    SDK --> Assistants
```

### 7. インフォグラフィックの作成

レポート作成後、対応するインフォグラフィックを生成する。

**参照**: `#[[file:../creating-infographic/SKILL.md]]`

#### インフォグラフィック生成ワークフロー

1. **レポートを読み込む**: `reports/YYYY/YYYY-MM-DD-<slug>.md`
2. **テーマを選択**: `openai-news` テーマを使用
3. **コンテンツを構成**:
   - 概要 (キーポイント、Before/After)
   - 主要機能カード
   - 技術詳細 (Mermaid 図、コードサンプル)
   - ユースケース
4. **HTML を生成**: `infographic/YYYY-MM-DD-<slug>.html`

#### 必須セクション

| セクション | 内容 |
|-----------|------|
| ヘッダー | タイトル、日付、カテゴリバッジ |
| 概要 | キーポイント (3-5 個) |
| 主要機能 | 機能カード (3-5 個) |
| 技術詳細 | アーキテクチャ図、コードサンプル |
| ユースケース | 2-3 個の具体例 |
| フッター | 出典 URL |

#### 追加セクション (情報がある場合)

- **Before/After 比較**: 変更前後の比較
- **統計情報**: パフォーマンス数値、改善率
- **API 変更点**: 新しいエンドポイント、パラメータ
- **料金情報**: コスト比較

#### 出力先

```
infographic/
├── 2026-03-07-gpt-5.html
├── 2026-03-05-openai-api-update.html
└── ...
```

## 出力形式

### ディレクトリ構造

```
reports/
├── 2026/
│   ├── 2026-03-07-gpt-5.md
│   ├── 2026-03-05-openai-api-update.md
│   └── ...
├── index.md
└── README.md
```

### レポートファイル形式

各レポートは以下の構造を持つ:

1. **タイトル**: アップデートの要約
2. **メタデータ**: 日付、ソース、カテゴリ
3. **概要**: 1-2 段落での要約
4. **詳細**: 技術的な説明
5. **影響**: 開発者への影響
6. **関連リンク**: 公式ドキュメントへのリンク

## 実行例

### 例 1: デフォルト実行 (過去 7 日間のアップデート)

```
OpenAI の最新ニュースをレポートしてください
```

### 例 2: 期間指定

```
過去 14 日間の OpenAI アップデートをレポートしてください
```

### 例 3: 特定トピック

```
OpenAI API の最新変更をレポートしてください
```

### 例 4: GPT モデル

```
GPT モデルの最新アップデートをレポートしてください
```

## 注意事項

1. **レート制限**: 各ソースへのリクエストは 1 回のみ
2. **キャッシュ**: 取得したデータは一時ファイルに保存
3. **日本語**: レポートは日本語で作成
4. **図表**: 必要に応じて Mermaid 図を追加
5. **リンク**: 公式ドキュメントへのリンクを必ず含める
