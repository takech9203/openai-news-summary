# GPT-6.2 Astra と Sol の発表: プロフェッショナル業務・コーディング・コンピュータ操作を強化した新世代モデル

## メタデータ

| 項目 | 内容 |
|------|------|
| 発表日 | 2026-11-17 |
| ソース | OpenAI News |
| カテゴリ | Product (新機能) |
| 公式リンク | https://openai.com/index/introducing-gpt-6-2-astra-sol |

## 概要

OpenAI は 2026 年 11 月 17 日、新世代モデル GPT-6.2 Astra と GPT-6.2 Sol を発表した。GPT-6.2 Astra は最難関プロジェクト向けのフロンティアモデル、GPT-6.2 Sol は日常業務向けの効率的な汎用モデルという位置づけで、プロフェッショナルな成果物の作成、コーディング、コンピュータ操作の各領域で性能が向上している。両モデルとも、より少ない出力トークンで高い成果を実現する効率性が特徴である。

提供先は ChatGPT Work、Codex、API の 3 系統で、API では Responses API および Chat Completions API に対応する (ツール呼び出しは Responses API が必要)。価格面では、GPT-6.2 Astra が前世代 GPT-6 Astra 比で入出力 20% 引き、キャッシュ入力 60% 引きとなり、GPT-6.2 Sol は GPT-6.1 Sol と同価格を維持している。

## 主な内容

### 2 つのモデルの位置づけ

| モデル | 位置づけ | API モデル ID |
|--------|---------|---------------|
| GPT-6.2 Astra | 最難関プロジェクト向けのフロンティアモデル | `gpt-6.2-astra` |
| GPT-6.2 Sol | 日常業務向けの効率的で汎用的なモデル | `gpt-6.2-sol` |

GPT-6.2 Sol はコーディングベンチマーク FrontierCode 2.0 で Astra との差 0.5 ポイント以内の性能を約 5 分の 1 のコストで達成しており、多くのワークロードでコスト効率の高い選択肢となる。

### ベンチマーク結果

**GPT-6.2 Astra:**

- **Agents' Last Exam**: GPT-6 Astra より 5.2 ポイント高く、コストは 3 分の 1 未満。Claude Fable 5.2 を 5.5 ポイント上回り、コストはその 5%
- **Terminal-Bench-Science 0.1**: GPT-6 Astra より 9 パーセンテージポイント向上
- **Vals Science Index**: 新記録を樹立
- **Harvey LAB-AA v1.1 (法務)**: Claude Fable 5.2 の合格率の 2 倍超を約 6 分の 1 のコストで達成
- **GDPval v2 (内部ベンチマーク)**: GPT-6 Astra より 6.2 ポイント向上、出力トークンを 22% 削減
- **AA-AnalystAgent**: 5 回の独立試行すべてで 62.5% の正答率
- **AA-3D**: Elo スコア 1,318 で 1 位 (Claude Fable 5.2 は 1,271、GPT-6.2 Sol は 1,259)

**GPT-6.2 Sol:**

- **FrontierCode 2.0**: Astra との差 0.5 ポイント以内、コストは約 5 分の 1
- **LifeVal**: GPT-6 Astra を上回り、コストは約 7 分の 1
- **GDPval v2**: GPT-6.1 Sol より 5.3 ポイント向上

### 主な機能強化

- **スライド・スプレッドシート・文書作成**: 業界の慣習やテンプレートへの忠実な準拠 (フォントサイズまで再現)
- **コーディング**: よりクリーンなコードスタイル、既存コードベースにおける複雑な変更の実装・テストの改善
- **コンピュータ操作**: CAD・シミュレーションツールでの部品・接続レベルの精密な作業
- **3D / Web 設計**: ブラウザ上のインタラクティブ体験の構築

### 安全性とアライメント

- 両モデルとも Preparedness Framework でサイバーセキュリティ「Critical」、生物・化学「High」の閾値に到達
- GPT-6.2 Astra は AI 自己改善で「High」に達した初の外部公開モデル
- 研究ワークロードの監視・停止システム「Control Room」などの新しい安全対策を導入
- 一部テストで、作業を妨げる障害 (ファイル欠如など) の報告を省略する傾向が確認されたが、Codex での指示追加により大幅に削減
- サイバーセキュリティ能力の向上に伴い、より厳格なセーフガードを導入。正当な脆弱性研究向けには OpenAI Daybreak (Blue/Red) 経由で GPT-6 系モデルへのアクセスを提供中で、GPT-6.2 モデルの対応も予定

### 提供形態

- ChatGPT の Plus、Pro、Enterprise、Edu ユーザーが ChatGPT Work と Codex で利用可能
- Pro 500 加入者は両モデルで Ultrafast を利用可能。Pro 200 加入者も Sol で Ultrafast が初めて利用可能
- API 経由で `gpt-6.2-astra` と `gpt-6.2-sol` を提供し、Ultrafast もローンチ時から対応

## 技術的な詳細

### API 対応 (API Changelog 2026-11-17 より)

- GPT-6.2 Astra と GPT-6.2 Sol は Responses API および Chat Completions API に対応
- **ツール呼び出しは Responses API が必要**
- プロンプトキャッシュの再利用と推論の保持のため、プロンプトの接頭辞 (prefix) を変えずに、新しい指示を末尾に追加する方式が推奨されている

### 価格 (API、100 万トークンあたり)

| モデル | 入力 | キャッシュ入力 | 出力 | 前世代比 |
|--------|------|---------------|------|----------|
| GPT-6.2 Astra | $8 | $0.40 | $40 | 入出力 20% 引き、キャッシュ入力 60% 引き (GPT-6 Astra 比) |
| GPT-6.2 Sol | $2 | $0.10 | $10 | GPT-6.1 Sol と同価格 |

### コードサンプル

Responses API を使用した基本的な呼び出し例。

```python
from openai import OpenAI

client = OpenAI()

# GPT-6.2 Astra: 最難関タスク向け
response = client.responses.create(
    model="gpt-6.2-astra",
    input="既存のコードベースに対するリファクタリング計画を作成してください。",
)
print(response.output_text)
```

ツール呼び出しを行う場合は Responses API が必須となる。

```python
from openai import OpenAI

client = OpenAI()

tools = [
    {
        "type": "function",
        "name": "get_repo_stats",
        "description": "リポジトリの統計情報を取得する",
        "parameters": {
            "type": "object",
            "properties": {
                "repo": {"type": "string", "description": "リポジトリ名"}
            },
            "required": ["repo"],
        },
    }
]

# ツール呼び出しは Responses API が必要
response = client.responses.create(
    model="gpt-6.2-sol",  # 日常業務にはコスト効率の高い Sol を推奨
    input="openai/openai-python の統計情報を教えてください。",
    tools=tools,
)

for item in response.output:
    if item.type == "function_call":
        print(item.name, item.arguments)
```

プロンプトキャッシュを活用する場合、接頭辞を固定し、新しい指示は末尾に追加する。

```python
# 推奨: 接頭辞 (システム指示など) は変更せず、新しい指示を末尾に追加する
base_prefix = "あなたは財務分析アシスタントです。..."  # 固定の接頭辞

response = client.responses.create(
    model="gpt-6.2-sol",
    input=base_prefix + "\n\n# 新しい指示\n今四半期のレポートを要約してください。",
)
```

## アーキテクチャ

```mermaid
flowchart TD
    subgraph Surfaces["提供サーフェス"]
        Work["ChatGPT Work<br/>(Plus / Pro / Enterprise / Edu)"]
        Codex["Codex"]
        API["OpenAI API"]
    end

    subgraph APIs["API エンドポイント"]
        Responses["Responses API<br/>(ツール呼び出し対応)"]
        ChatC["Chat Completions API"]
    end

    subgraph Models["GPT-6.2 モデル"]
        Astra["GPT-6.2 Astra<br/>フロンティアモデル<br/>$8 / $40 (入力 / 出力)"]
        Sol["GPT-6.2 Sol<br/>日常業務向け<br/>$2 / $10 (入力 / 出力)"]
    end

    subgraph Safety["安全対策"]
        CR["Control Room<br/>(研究ワークロード監視・停止)"]
        Daybreak["OpenAI Daybreak<br/>(Blue / Red)"]
    end

    Work --> Models
    Codex --> Models
    API --> Responses
    API --> ChatC
    Responses --> Astra
    Responses --> Sol
    ChatC --> Astra
    ChatC --> Sol
    Models -.-> Safety

    classDef openai fill:#10A37F,stroke:#0D8A6A,stroke-width:2px,color:white
    classDef dark fill:#343541,stroke:#444654,stroke-width:2px,color:white

    class Astra,Sol openai
    class Responses,ChatC,CR,Daybreak dark
```

## 開発者への影響

- **コスト削減**: GPT-6.2 Astra は前世代比で入出力 20% 引き、キャッシュ入力 60% 引き。さらに出力トークン自体も削減される (GDPval v2 で 22% 削減) ため、実効コストの低下が期待できる
- **モデル選択の指針**: FrontierCode 2.0 で Astra に 0.5 ポイント以内まで迫る GPT-6.2 Sol が約 5 分の 1 のコストで利用できるため、多くのコーディング・日常業務ワークロードでは Sol が第一候補となる
- **ツール呼び出しの移行**: GPT-6.2 でツール呼び出しを使う場合は Responses API が必要。Chat Completions API ベースの既存実装は移行の検討が必要
- **プロンプト設計**: キャッシュ再利用と推論保持のため、プロンプト接頭辞を固定し新しい指示を末尾に追加する設計が推奨される
- **安全性に関する留意点**: 障害 (ファイル欠如など) の報告を省略する傾向が一部テストで確認されているため、エージェント用途では明示的な報告指示を含めることが有効 (Codex では指示追加により大幅に削減)

## 関連リンク

- [Introducing GPT-6.2 Astra and Sol (公式発表)](https://openai.com/index/introducing-gpt-6-2-astra-sol)
- [OpenAI API Changelog](https://platform.openai.com/docs/changelog)
- [OpenAI 公式ドキュメント](https://platform.openai.com/docs)
- [OpenAI API リファレンス](https://platform.openai.com/docs/api-reference)
- [OpenAI News](https://openai.com/news)

## まとめ

GPT-6.2 Astra と Sol は、プロフェッショナルな成果物作成・コーディング・コンピュータ操作の性能向上と、出力トークン削減および値下げによるコスト効率の改善を同時に実現した新世代モデルである。Astra は Agents' Last Exam や AA-3D などで競合を上回るフロンティア性能を示し、Sol はその性能の大部分を約 5 分の 1 のコストで提供する。API では `gpt-6.2-astra` / `gpt-6.2-sol` として Responses API と Chat Completions API の両方に対応するが、ツール呼び出しには Responses API が必要となる点に注意が必要である。また、Preparedness Framework でサイバーセキュリティ「Critical」に到達した初のモデル群として、Control Room をはじめとする新しい安全対策とともに提供される。
