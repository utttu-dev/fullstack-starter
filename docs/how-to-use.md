# 使い方ガイド

このテンプレートを使って新しいプロジェクトを始める手順。

---

## 1. プロジェクトをコピーする

```bash
git clone https://github.com/<username>/fullstack-starter.git my-new-app
cd my-new-app
rm -rf .git
git init
```

---

## 2. バックエンドを設定する

```bash
cp docker/Dockerfile.backend.example docker/Dockerfile
```

`docker/Dockerfile` を開き、以下のプレースホルダを書き換える。

| プレースホルダ | 説明 | 例 |
| -------------- | ------ | ----- |
| `<YOUR_LANG_RUNTIME>` | ビルド用のベースイメージ | `python:3.12-slim` |
| `<DEPENDENCY_FILES>` | 依存定義ファイル | `pyproject.toml uv.lock` |
| `<INSTALL_DEPENDENCIES_COMMAND>` | 依存関係インストールコマンド | `uv sync --frozen --no-cache` |
| `<DEPENDENCY_OUTPUT_PATH>` | インストール先パス | `/app/.venv` |
| `<SRC_DIR>` | ソースコードのディレクトリ | `src` |
| `<APP_PORT>` | アプリの待受ポート | `8000` |
| `<START_COMMAND>` | 起動コマンド | `["uvicorn", "src.main:app", "--host", "0.0.0.0"]` |

---

## 3. フロントエンドを設定する

```bash
cp docker/Dockerfile.frontend.example frontend/Dockerfile
```

| プレースホルダ | 説明 | 例 |
| -------------- | ------ | ----- |
| `<BUILD_OUTPUT_DIR>` | ビルド成果物の出力先 | `dist`(Vite) / `build`(CRA) |

---

## 4. docker-compose.yml を設定する

```bash
cp docker/docker-compose.yml.example docker/docker-compose.yml
```

| プレースホルダ | 説明 | 例 |
| -------------- | ------ | ----- |
| `<BACKEND_PORT>` | バックエンドのポート | `8000` |
| `<DB_DRIVER>` | DB接続ドライバ | `mysql+pymysql` / `postgresql` |
| `<DB_IMAGE>` | DBのDockerイメージ | `mysql:8.0` / `postgres:16` |
| `<DB_USER>` / `<DB_PASSWORD>` / `<DB_NAME>` | DB接続情報 | 任意 |
| `<DB_INTERNAL_PORT>` / `<DB_EXTERNAL_PORT>` | DBのポート(コンテナ内/ホスト公開) | `3306` / `3308` |
| `<DB_DATA_DIR>` | DBデータの永続化先 | `mysql` / `postgresql` |

---

## 5. CIを設定する

```bash
cp .github/workflows/ci.yml.example .github/workflows/ci.yml
```

| プレースホルダ | 説明 |
| -------------- | ------ |
| `<SETUP_BACKEND_COMMAND>` | バックエンド言語のセットアップ |
| `<INSTALL_BACKEND_DEPS_COMMAND>` | 依存関係インストール |
| `<LINT_COMMAND>` | Lintコマンド |
| `<TEST_COMMAND>` | テストコマンド |
| `<MIGRATION_COMMAND>` | DBマイグレーション実行コマンド |

---

## 6. Kubernetesマニフェストを設定する(任意)

ローカルでk8sを試したい場合のみ。

```bash
cp k8s/deployment.yaml.example k8s/deployment.yaml
cp k8s/service.yaml.example k8s/service.yaml
cp k8s/configmap.yaml.example k8s/configmap.yaml
cp k8s/hpa.yaml.example k8s/hpa.yaml
cp k8s/db-deployment.yaml.example k8s/db-deployment.yaml
```

各ファイル内の `<APP_NAME>` 等のプレースホルダを置き換える。

```bash
minikube start --driver=docker
docker build -f docker/Dockerfile -t <APP_NAME>:local .
minikube image load <APP_NAME>:local
kubectl apply -f k8s/
```

---

## 7. 開発フロースクリプトを設定する

```bash
cp scripts/e2e-local.ps1.example scripts/e2e-local.ps1
```

`check.ps1` と `reset-docker.ps1` 内の `<LINT_COMMAND>` `<TEST_COMMAND>` `<MIGRATION_COMMAND>` `<BACKEND_PORT>` を書き換える。

---

## 8. 動作確認

```bash
docker compose -f docker/docker-compose.yml up -d --build
.\scripts\check.ps1
```
