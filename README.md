# MCP 開発プロジェクト

## 開発環境のセットアップ

このプロジェクトは VS Code Remote Containers を使用して開発環境を構築します。

### 前提条件

- Docker
- Visual Studio Code
- Remote - Containers 拡張機能

### セットアップ手順

1. リポジトリをクローン

```
git clone <repository-url> .devcontainer
```

2. VS Code のコマンドパレットから Remote-Containers: Reopen in Container を選択

3. コンテナ内で初期化

```
npm init -y
```

4. コンテナ内で依存関係をインストール

```
pnpm install
```

## ネットワーク設定

この DevContainer は以下のネットワーク設定を持っています：

- **MCP ネットワーク** (`--network=mcp-network`)

  - 専用の Docker ネットワーク
  - 他の MCP 関連コンテナとの通信用
  - 自動ネットワーク作成: コンテナ起動前に自動的に作成されるため、手動での作成は不要です
  - 既にネットワークが存在する場合は、既存のものが使用されます

- **コンテナ名** (`containerName: mcp-dev`)
  - 固定のコンテナ名「mcp-dev」を使用
  - これにより、他のコンテナからは「mcp-dev:3001」の形式でアクセス可能

デフォルトでは、ポート 3001 が使用されます。

## 権限設定

この DevContainer は以下の権限設定を持っています：

- **ユーザー ID 同期** (`updateRemoteUserUID: true`)

  - コンテナ内のユーザー ID をホスト側のユーザー ID に自動的に合わせる
  - これにより、ファイル所有権の問題を防止

- **SSH キーのマウント**
  - ホストの`~/.ssh`ディレクトリをコンテナ内の`/home/node/.ssh`に読み取り専用でマウント
  - これにより、コンテナ内で git コマンドを使用する際にホストの SSH 鍵を使用可能
  - セキュリティのため読み取り専用でマウントされる

## TypeScript の実行方法

このプロジェクトでは Node.js v23 と pnpm を使用しています：

```bash
# TypeScriptをコンパイルして実行
pnpm tsc
node dist/index.js

# package.jsonにスクリプトを追加した場合
# "scripts": { "dev": "ts-node src/index.ts" }
pnpm dev

# 本番用にビルド
pnpm tsc
# または
pnpm build # package.jsonに"build": "tsc"を設定している場合
```

pnpm の主な利点：

- 高速なパッケージマネージャー
- ディスク容量の節約（パッケージの重複を避ける）
- 厳格な依存関係管理

## 使用技術

- Node.js v23（JavaScript ランタイム）
- pnpm（パッケージマネージャー）
