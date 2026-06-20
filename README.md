# fullstack-starter

Frontend / Backend / DB の構成を指定するだけで、Docker・CI/CD・Kubernetes が
標準装備された開発環境をすぐに立ち上げられるテンプレートリポジトリ。

[todo-api](https://github.com/<username>/todo-api) の開発を通じて確立した
「Docker / CI / Kubernetes の標準パターン」を、アプリケーションから切り離して
再利用できる形にまとめたもの。

---

## 何ができるか

このテンプレートをコピーして使うと、以下が標準で揃った状態から開発を始められる。

- Docker(マルチステージビルド、backend/frontend)
- docker-compose(frontend + backend + db の3層構成)
- GitHub Actions CI(Lint → Test → Build → E2E)
- Kubernetes マニフェスト(Deployment/Service/HPA/ConfigMap/Secret)
- 開発フロー用スクリプト(Lintチェック・Dockerリセット等)

---

## 含まれていないもの(意図的に空にしているもの)

このリポジトリは「型」のみを提供する。アプリケーション固有のコードは含まれていない。

- バックエンドのビジネスロジック(エンドポイント・DBモデル等)
- フロントエンドの画面・コンポーネント
- DBのテーブル定義

これらは利用するプロジェクトごとに実装する。

---

## 使い方

詳細は [docs/how-to-use.md](docs/how-to-use.md) を参照。

```bash
# 1. このリポジトリをコピーして新しいプロジェクトを作る
git clone https://github.com/<username>/fullstack-starter.git my-new-app
cd my-new-app
rm -rf .git && git init

# 2. .example ファイルをコピーして使う
cp docker/Dockerfile.backend.example docker/Dockerfile
cp docker/docker-compose.yml.example docker/docker-compose.yml
cp .github/workflows/ci.yml.example .github/workflows/ci.yml

# 3. プレースホルダを自分のアプリに合わせて書き換える
#    (詳細は各.exampleファイル内のコメントを参照)
```

---

## 構成

```
fullstack-starter/
├── docker/
│   ├── Dockerfile.backend.example     バックエンド用マルチステージビルド
│   ├── Dockerfile.frontend.example    フロントエンド用(Vite build → nginx)
│   └── docker-compose.yml.example     frontend + backend + db
├── .github/
│   └── workflows/
│       └── ci.yml.example             Lint → Test → Build → E2E
├── k8s/
│   ├── deployment.yaml.example
│   ├── service.yaml.example
│   ├── configmap.yaml.example
│   ├── hpa.yaml.example
│   └── db-deployment.yaml.example
├── scripts/
│   ├── check.ps1                      Lint + Test(汎用、そのまま使える)
│   ├── reset-docker.ps1               Dockerキャッシュ問題の完全リセット(汎用)
│   └── e2e-local.ps1.example          Docker起動 + E2E実行
└── docs/
    ├── how-to-use.md                  詳細な利用手順
    └── design-principles.md           設計思想・なぜこの構成にしたか
```

---

## 設計思想

このテンプレートが大事にしている考え方は [docs/design-principles.md](docs/design-principles.md) を参照。

簡単に言うと、「環境構築」だけでなく、QCD(品質・コスト・スピード)を
最大化する仕組みを最初から組み込む、という方針で作られている。

---
