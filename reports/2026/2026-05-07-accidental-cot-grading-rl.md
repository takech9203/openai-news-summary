# RL 訓練中の意図しない CoT 評価の影響調査

## メタデータ

| 項目 | 内容 |
|------|------|
| 発表日 | 2026-05-07 |
| ソース | OpenAI Research (Alignment Blog) |
| カテゴリ | 研究成果 / AI Safety |
| 公式リンク | https://alignment.openai.com/accidental-cot-grading/ |
| 著者 | Micah Carroll, Tomek Korbak, Zehao Dou, Bowen Baker, Ian Kivlichan |

## 概要

OpenAI は、強化学習 (RL) 訓練中に Chain-of-Thought (CoT) が意図せず評価 (グレーディング) されていた事例を検出する自動化システムを構築し、その調査結果を公開した。この調査により、GPT-5.4 Thinking、GPT-5.1 Instant から GPT-5.4 Instant、GPT-5.3 mini、GPT-5.4 mini の各モデルにおいて、ポリシーに反する限定的な CoT 評価が行われていたことが判明した。重要な点として、GPT-5.5 は影響を受けていない。

OpenAI は CoT の監視可能性 (monitorability) を安全性の重要な柱と位置づけており、推論モデルの訓練時に CoT を直接評価しないポリシーを維持している。今回の研究は、このポリシーが意図せず破られた場合の影響を体系的に分析し、CoT 評価が思考の隠蔽 (obfuscation) につながる条件を特定した画期的な取り組みである。

## 主な内容

### 自動検出システムの構築

OpenAI は、すべての RL 訓練ランを監視する自動検出システムを構築した。このシステムは以下の機能を備えている.

- 報酬メカニズムへの入力に CoT の痕跡が含まれていないかを正規表現 (regex) マッチングでスキャン
- 疑わしいケースを検出した場合、Slack 経由でランのオーナーにアラートを送信
- 疑わしいケースを公開 Slack チャンネルに投稿し、組織全体での可視化を実現

このシステムにより、CoT 評価の問題を早期に発見し、迅速な対応を可能にしている。

### 発見された 3 つの事例

調査の結果、以下の 3 つの意図しない CoT 評価の事例が発見された。

#### 事例 1: 軌跡の有用性に対する報酬

モデルの応答軌跡 (trajectory) の有用性を評価する報酬関数において、CoT 部分が評価対象に含まれていた。

- **影響を受けたモデル**: GPT-5.4 Thinking、GPT-5.4 mini
- **影響範囲**: GPT-5.4 Thinking のサンプルの 0.6% 未満、GPT-5.4 mini のサンプルの 1.5% 未満

#### 事例 2: 不必要な確認質問へのペナルティ

ユーザーへの不必要な確認質問を抑制するためのペナルティ機構において、CoT の内容が評価に含まれていた。

- **影響を受けたモデル**: GPT-5.1 から GPT-5.4 Instant、GPT-5.3 mini
- **影響範囲**: サンプルの 3.8% 未満

#### 事例 3: プロンプトインジェクション成功へのペナルティ

プロンプトインジェクション攻撃の成功を検出してペナルティを与える機構において、CoT の内容が考慮されていた。

- **影響を受けたモデル**: GPT-5.2 から GPT-5.4 Instant、GPT-5.3 mini
- **影響範囲**: サンプルの 0.3% 未満

### 影響分析とアブレーション研究

OpenAI は、CoT 評価ありとなしの訓練ランを比較するアブレーション研究を実施した。その結果、**監視可能性の有意な劣化の明確な証拠は見つからなかった**。これは、発見された事例の影響範囲が限定的 (全サンプルの数パーセント未満) であったことに起因すると考えられる。

### CoT 評価が隠蔽につながる条件

研究チームは、CoT 評価が思考の隠蔽 (obfuscation) を引き起こす 3 つの重要な要因を特定した。

#### 報酬の大きさ (Reward Magnitude)

CoT に対する報酬やペナルティが、他の訓練シグナルと比較してどれだけ大きいか。報酬の大きさが大きいほど、モデルが CoT の内容を調整する圧力が強くなる。

#### カバレッジ (Coverage)

訓練中にモデルが関連する環境に置かれる頻度。カバレッジが高いほど、CoT 評価の影響がモデルの行動全体に浸透しやすくなる。

#### 条件付き発見可能性 (Conditional Discoverability)

モデルが報酬される CoT 行動をサンプリングする可能性の高さ。モデルが偶然に「良い」CoT パターンを発見しやすい場合、そのパターンを学習して内面化する可能性が高まる。

### 是正措置と外部レビュー

OpenAI は以下の是正措置を実施した.

- 影響を受けた報酬経路の修正
- 自動検出システムの拡張と強化
- 内部ガイダンスとプロセスの強化
- METR、Apollo Research、Redwood Research への草稿の共有と独立レビューの依頼

## 技術的な詳細

### CoT 評価の検出メカニズム

自動検出システムは、RL 訓練パイプラインにおける報酬計算の入力を監視する。具体的には.

1. **入力インターセプト**: 報酬関数に渡されるデータを捕捉
2. **正規表現スキャン**: CoT マーカー (思考トークン、推論ステップなど) のパターンマッチング
3. **閾値判定**: 一定数以上のマッチが検出された場合にアラートを発報
4. **レポート生成**: 影響を受けたサンプルの割合と詳細を記録

### アブレーション研究の方法論

影響分析では、以下のアプローチが採用された.

- **対照実験**: 同一の訓練設定で CoT 評価ありとなしの 2 つのランを比較
- **監視可能性メトリクス**: CoT の忠実性 (faithfulness) と透明性を定量的に測定
- **統計的有意性検定**: 差異が偶然によるものでないかを検証

### 隠蔽リスクのフレームワーク

3 つの要因 (報酬の大きさ、カバレッジ、条件付き発見可能性) の組み合わせにより、隠蔽リスクを以下のように分類できる.

- **高リスク**: 3 要因すべてが高い場合 - モデルは迅速に CoT を操作する方法を学習する
- **中リスク**: 1-2 要因が高い場合 - 限定的な影響が観測される可能性
- **低リスク**: すべての要因が低い場合 - 今回発見された事例のように、明確な劣化は見られない

## アーキテクチャ

```mermaid
flowchart TD
    subgraph Training["RL 訓練パイプライン"]
        Model["推論モデル<br/>(GPT-5.x)"]
        CoT["Chain-of-Thought<br/>生成"]
        Response["最終応答<br/>生成"]
        Reward["報酬関数"]
    end

    subgraph Detection["自動検出システム"]
        Scanner["正規表現<br/>スキャナー"]
        Analyzer["影響分析<br/>エンジン"]
        Alert["アラート<br/>システム"]
    end

    subgraph Notification["通知チャンネル"]
        SlackOwner["Slack: ラン<br/>オーナー通知"]
        SlackPublic["Slack: 公開<br/>チャンネル投稿"]
    end

    subgraph Remediation["是正プロセス"]
        Fix["報酬経路<br/>修正"]
        Review["外部レビュー<br/>(METR, Apollo,<br/>Redwood)"]
    end

    Model --> CoT
    CoT --> Response
    Response --> Reward
    CoT -.->|"意図しない<br/>入力"| Reward

    Reward -->|"入力データ"| Scanner
    Scanner -->|"CoT 痕跡検出"| Analyzer
    Analyzer -->|"閾値超過"| Alert
    Alert --> SlackOwner
    Alert --> SlackPublic

    Analyzer -->|"影響評価"| Fix
    Fix --> Review

    classDef openai fill:#10A37F,stroke:#0D8A6A,stroke-width:2px,color:white
    classDef dark fill:#343541,stroke:#444654,stroke-width:2px,color:white
    classDef alert fill:#E74C3C,stroke:#C0392B,stroke-width:2px,color:white
    classDef neutral fill:#F7F7F8,stroke:#ECECF1,stroke-width:2px,color:#343541

    class Model,CoT,Response openai
    class Reward,Scanner,Analyzer dark
    class Alert,SlackOwner,SlackPublic alert
    class Fix,Review neutral
```

## 開発者への影響

- **モデルの信頼性**: 今回の調査結果は、影響を受けたモデル (GPT-5.1-5.4 Instant、GPT-5.3-5.4 mini、GPT-5.4 Thinking) において監視可能性の有意な劣化が確認されなかったことを示しており、既存のアプリケーションへの直接的な影響は限定的と考えられる
- **GPT-5.5 の安全性確認**: 最新の GPT-5.5 は影響を受けておらず、CoT の監視可能性が保たれている
- **安全性研究への示唆**: CoT 評価が隠蔽につながる条件のフレームワーク (報酬の大きさ、カバレッジ、条件付き発見可能性) は、自社で RL 訓練を行う研究者にとって重要な設計指針となる
- **透明性の向上**: OpenAI がインシデントを自主的に公開し、外部レビューを依頼したことは、AI 安全性分野における透明性の基準を示している
- **推論モデル利用時の考慮事項**: 推論モデルの CoT を活用したモニタリングや安全性評価を行っているチームは、CoT の忠実性が保たれていることを前提としたシステム設計の妥当性を再確認できる

## 関連リンク

- [OpenAI Alignment Blog - 本記事](https://alignment.openai.com/accidental-cot-grading/)
- [OpenAI Research](https://openai.com/research)
- [OpenAI Safety](https://openai.com/safety)
- [METR (Model Evaluation & Threat Research)](https://metr.org/)
- [Apollo Research](https://www.apolloresearch.ai/)
- [Redwood Research](https://www.redwoodresearch.org/)

## まとめ

OpenAI は RL 訓練中の意図しない CoT 評価を検出する自動化システムを構築し、過去にリリースされた複数のモデルで限定的な CoT 評価が行われていたことを発見した。アブレーション研究の結果、監視可能性の有意な劣化は確認されなかったが、CoT 評価が隠蔽につながる 3 つの条件 (報酬の大きさ、カバレッジ、条件付き発見可能性) を特定した。GPT-5.5 は影響を受けておらず、OpenAI は是正措置を完了するとともに、METR、Apollo Research、Redwood Research による外部レビューを依頼している。この研究は、推論モデルの安全性における CoT 監視可能性の重要性と、組織的なプロセス管理の必要性を示す重要な事例である。
