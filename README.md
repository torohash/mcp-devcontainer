# MCP開発プロジェクト

## 開発環境のセットアップ

このプロジェクトはVS Code Remote Containersを使用して開発環境を構築します。

### 前提条件

- Docker
- Visual Studio Code
- Remote - Containers拡張機能

### セットアップ手順

1. リポジトリをクローン
  ```
  git clone <repository-url> .devcontainer
  ```

2. VS CodeのコマンドパレットからRemote-Containers: Reopen in Containerを選択

3. コンテナ内で初期化
  ```
  bun init
  ```

4. コンテナ内で依存関係をインストール
  ```
  bun install
  ```

5. 開発サーバーを起動
  ```
  bun dev
  ```

## ネットワーク設定

このDevContainerは以下のネットワーク設定を持っています：

- **MCPネットワーク** (`--network=mcp-network`)
  - 専用のDockerネットワーク
  - 他のMCP関連コンテナとの通信用
  - 自動ネットワーク作成: コンテナ起動前に自動的に作成されるため、手動での作成は不要です
  - 既にネットワークが存在する場合は、既存のものが使用されます

- **コンテナ名** (`containerName: mcp-dev`)
  - 固定のコンテナ名「mcp-dev」を使用
  - これにより、他のコンテナからは「mcp-dev:3001」の形式でアクセス可能

デフォルトでは、ポート3001が使用されます。

## 権限設定

このDevContainerは以下の権限設定を持っています：

- **ユーザーID同期** (`updateRemoteUserUID: true`)
  - コンテナ内のユーザーIDをホスト側のユーザーIDに自動的に合わせる
  - これにより、ファイル所有権の問題を防止

- **SSHキーのマウント**
  - ホストの`~/.ssh`ディレクトリをコンテナ内の`/home/bun/.ssh`に読み取り専用でマウント
  - これにより、コンテナ内でgitコマンドを使用する際にホストのSSH鍵を使用可能
  - セキュリティのため読み取り専用でマウントされる

## TypeScriptの実行方法

このプロジェクトではbun (v1.2.6)を使用しており、TypeScriptを直接実行できます：

```bash
# TypeScriptファイルを直接実行
bun run src/index.ts

# package.jsonにスクリプトを追加した場合
# "scripts": { "dev": "bun run src/index.ts" }
bun dev

# 本番用にビルド
bun build ./src/index.ts --outdir ./dist
```

bunの主な利点：
- TypeScriptを直接実行可能（追加のツールが不要）
- 高速なパッケージマネージャー
- 高速なJavaScriptランタイム
- ビルトインのバンドラー、テストランナー

## 使用技術

- Bun v1.2.6（JavaScriptランタイムとパッケージマネージャー）