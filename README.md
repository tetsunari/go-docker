# AtCoder Go Development Environment

Docker + Dev Container を使用したAtCoder問題解答用のGo開発環境です。

## 🚀 使用方法

### Dev Container（推奨）

1. **VS Codeでプロジェクトを開く**
   ```bash
   code .
   ```

2. **Dev Containerで開き直す**
   - VS Code右下に表示される「Reopen in Container」をクリック
   - または、`Ctrl+Shift+P` → `Dev Containers: Reopen in Container`

3. **自動でコンテナがビルド・起動され、開発環境が整います**

### 開発の流れ

1. **VS Codeのターミナルで開発開始**
   ```bash
   # airを起動（ファイル変更時の自動リビルド）
   air -c .air.toml
   ```

2. **プログラムの実行とテスト**
   ```bash
   # airを使わない場合（手動ビルド）
   go run main.go < input.txt
   go run main.go < input2.txt
   
   # またはビルドしてから実行
   go build -o main .
   ./main < input.txt
   ./main < input2.txt
   
   # airを使っている場合（自動ビルド済み）
   ./tmp/main < input.txt
   ./tmp/main < input2.txt
   
   # テストケース一括実行
   echo "=== Test Case 1 (should output: Yes) ===" && ./tmp/main < input.txt
   echo "=== Test Case 2 (should output: No) ===" && ./tmp/main < input2.txt
   ```

3. **コードを編集すると自動的にリビルドされます**

### 従来のDocker Compose（参考）

```bash
# 開発用コンテナの起動
docker compose up -d atcoder-dev

# プログラムの実行
docker compose exec atcoder-dev /bin/sh -c "echo '3 5' | ./tmp/main"

# 停止
docker compose down
```

## 📁 ファイル構成

```
.
├── .devcontainer/
│   └── devcontainer.json    # Dev Container設定
├── Dockerfile               # マルチステージビルド
├── compose.yaml            # Docker Compose設定
├── .air.toml               # air設定（自動リビルド）
├── go.mod                  # Goモジュール
├── main.go                 # AtCoder問題解答プログラム
├── input.txt               # テストケース1（Yes出力）
└── input2.txt              # テストケース2（No出力）
```

## 🔧 設定されている機能

- **Go 1.23 環境**
- **air による自動リビルド**
- **VS Code統合（gopls、デバッガ）**
- **GitHub Copilot対応**
- **効率的なDocker層キャッシュ**
- **Go modules キャッシュ**

## 💡 Tips

- `Ctrl+Shift+P` → `Go: Install/Update Tools` でGo開発ツールを更新
- デバッグはVS Code内で`F5`キーで開始
- ターミナルは最初からコンテナ内で開きます