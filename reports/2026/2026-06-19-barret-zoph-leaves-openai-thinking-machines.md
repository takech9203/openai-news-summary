# Barret Zoph が わずか 5 ヶ月で再び OpenAI を離脱 -- 新会社 Thinking Machines Lab を設立

## メタデータ

| 項目 | 内容 |
|------|------|
| 発表日 | 2026-06-19 |
| ソース | The Verge / 業界ニュース |
| カテゴリ | 人事 / 企業ニュース |
| 公式リンク | [The Verge](https://www.theverge.com/ai-artificial-intelligence/952837/barret-zoph-openai-thinking-machines-lab) |

## 概要

2026 年 6 月 19 日、OpenAI の VP of Post-Training を務めていた Barret Zoph が同社を離脱し、新会社 Thinking Machines Lab を設立することが The Verge により報じられた。Zoph は 2024 年 9 月に一度 OpenAI を退社した後、約 5 ヶ月前 (2026 年 1 月頃) に復帰したばかりであり、わずか 5 ヶ月での再離脱は異例の短期間である。

Post-Training は大規模言語モデルを実用的な製品に仕上げる最も重要なフェーズの一つであり、RLHF (人間のフィードバックによる強化学習)、指示追従訓練、安全性トレーニングなどを統括する役割を担っていた。その責任者の離脱は、ChatGPT をはじめとする OpenAI 製品の品質と方向性に影響を与える可能性がある。

## 主な内容

### Barret Zoph の経歴と OpenAI での役割

Barret Zoph は、ニューラルアーキテクチャ探索 (Neural Architecture Search, NAS) やモデルスケーリングに関する研究で知られる AI 研究者である。OpenAI では VP of Post-Training として、以下の領域を統括していた。

- **RLHF (Reinforcement Learning from Human Feedback):** 人間の評価を基にモデルの出力品質を向上させる強化学習手法
- **Instruction Tuning:** モデルがユーザーの指示を正確に理解し従うための微調整
- **Safety Training:** 有害な出力を防止し、モデルの安全性を確保するためのトレーニング
- **Model Refinement:** ベースモデルからエンドユーザー向け製品としての品質に仕上げる最終調整

これらの工程は、GPT シリーズが「賢いが使いにくいベースモデル」から「誰でも直感的に使える ChatGPT」へと変貌するための核心技術であり、その責任者の離脱は組織として重大な変化を意味する。

### 2 年間で 2 度の離脱

Zoph の OpenAI との関係は、近年不安定な軌跡をたどっている。

| 時期 | 出来事 |
|------|--------|
| ~2024 年 9 月以前 | OpenAI で Post-Training を主導 |
| 2024 年 9 月 | OpenAI を退社 (1 回目の離脱) |
| 2026 年 1 月頃 | OpenAI に復帰、VP of Post-Training に就任 |
| 2026 年 6 月 | 再び OpenAI を離脱 (2 回目の離脱、わずか 5 ヶ月) |

わずか 2 年弱の間に 2 度の離脱を選択したことは、OpenAI 内部の方向性や組織文化との不一致、あるいは独立研究への強い意志が存在する可能性を示唆している。

### Thinking Machines Lab の設立

Zoph が新たに設立する Thinking Machines Lab の詳細は現時点で限定的であるが、その名称とZoph のバックグラウンドから以下の方向性が推測される。

- **推論 (Reasoning) 能力の追求:** "Thinking Machines" という名称は、モデルの思考・推論プロセスに焦点を当てた研究を示唆
- **Post-Training 技術の発展:** RLHF やアライメント技術における新たなアプローチの模索
- **アーキテクチャ探索:** NAS 研究の経験を活かした次世代モデル設計の可能性

### OpenAI の人材流動: 流入と流出の同時進行

今回の離脱は、前日 (6 月 18 日) に報じられた Noam Shazeer の OpenAI 参画と対照的なニュースである。OpenAI は Transformer の共同発明者を獲得する一方で、Post-Training の責任者を失うという、人材の流入と流出が同時に起きている状況にある。

| 流入 | 流出 |
|------|------|
| Noam Shazeer (Google から) | Barret Zoph (Thinking Machines Lab へ) |
| 新 CFO / CPO の採用 | 過去: Ilya Sutskever、Jan Leike ほか |

この動態は、OpenAI が組織として急速に変化しており、一部の研究者にとっては馴染みにくい環境になりつつある可能性を示している。

## 技術的な詳細

### Post-Training パイプラインの概要

Post-Training は、事前学習済みのベースモデルをエンドユーザー向け製品に変換する一連のプロセスである。

```
ベースモデル (Pre-trained)
    │
    ├─ Supervised Fine-Tuning (SFT)
    │   └─ 高品質な指示-応答ペアでの教師あり微調整
    │
    ├─ RLHF / RLAIF
    │   ├─ 報酬モデルの学習
    │   └─ PPO / DPO による方策最適化
    │
    ├─ Safety Training
    │   ├─ Red-teaming による脆弱性発見
    │   └─ 安全性制約の組み込み
    │
    └─ Evaluation & Iteration
        ├─ ベンチマーク評価
        └─ 人間評価による品質確認
            │
            ▼
    製品モデル (ChatGPT, API Models)
```

Zoph はこのパイプライン全体を統括する立場にあり、ChatGPT の「性格」や「振る舞い」を決定する最終工程の責任者であった。

### Neural Architecture Search (NAS) の貢献

Zoph の代表的な研究成果である NAS は、ニューラルネットワークの設計を自動化する手法であり、以下のような影響を AI 分野に与えた。

- **NASNet (2018):** 強化学習を用いてアーキテクチャを自動探索し、手動設計を上回る性能を達成
- **EfficientNet への貢献:** スケーリング法則の発見につながる基礎研究
- **モデル効率化:** 計算コストと性能のトレードオフを最適化する設計指針の確立

## 開発者への影響

今回の人事異動は API の直接的な変更を伴わないが、中長期的に以下の影響が考えられる。

- **モデル品質への潜在的影響:** Post-Training 責任者の交代により、将来のモデルリリースにおける instruction following の品質や安全性のバランスに変化が生じる可能性がある。開発者は今後のモデルアップデートにおける挙動変化に注意を払うべきである
- **リリーススケジュールへの影響:** 主要な技術リーダーの離脱に伴う組織再編が、次期モデルのリリース時期に影響を与える可能性がある
- **競合環境の変化:** Thinking Machines Lab が Post-Training 技術で独自のブレークスルーを達成した場合、開発者にとって新たなモデル選択肢が生まれる可能性がある
- **OpenAI の組織的回復力:** 一方で、OpenAI は過去にも主要人材の離脱 (Ilya Sutskever、Andrej Karpathy 等) を経験しながらも製品品質を維持してきた実績がある。組織としての知識の蓄積とプロセスの成熟度が問われる局面である
- **Noam Shazeer の参画による相殺:** 前日に発表された Shazeer の参画は、基盤研究の強化という観点で Zoph の離脱を部分的に相殺する可能性がある

## 関連リンク

- [The Verge: Barret Zoph leaves OpenAI](https://www.theverge.com/ai-artificial-intelligence/952837/barret-zoph-openai-thinking-machines-lab)
- [OpenAI News](https://openai.com/news)
- [OpenAI About](https://openai.com/about)
- [Neural Architecture Search with Reinforcement Learning (arXiv)](https://arxiv.org/abs/1611.01578)

## まとめ

Barret Zoph の わずか 5 ヶ月での OpenAI 再離脱と Thinking Machines Lab の設立は、AI 業界における人材流動の激しさと、トップ研究者が大組織に留まることの難しさを改めて浮き彫りにしている。Post-Training という ChatGPT の品質を左右する核心領域の責任者を失うことは OpenAI にとって痛手であるが、同社は Noam Shazeer の参画をはじめとする積極的な人材獲得で対応している。開発者としては、今後のモデルアップデートにおける品質変化を注視しつつ、Thinking Machines Lab がもたらす可能性のある新たな技術的選択肢にも目を配るべきである。
