# 概要
auto-appは、次世代シーケンシング（NGS）データの処理を自動化するためのPythonスクリプトです。指定されたプロジェクト番号（project accession）に基づいて、European Nucleotide Archive (ENA) から対応するシーケンスデータをサンプルアクセッションごとにダウンロードし、各サンプルに対してデータのマージと品質解析を行います。

## 主な機能
1. **データダウンロード**: 指定したプロジェクト番号に関連する全サンプルデータをENAからダウンロードし、サンプルアクセッションごとにディレクトリに整理します。
2. **データマージ**: ダウンロードされた各サンプルのFASTQファイルをNextflowを使用してマージします。
3. **品質解析**: マージされたFASTQファイルに対してFastQCを使用して品質解析を実行し、結果をサンプルごとに保存します。

## ディレクトリ構成
auto-app/<br> 
├── README.md                        # プロジェクトの概要と説明<br>
├── auto.py                          # メインのPythonスクリプト<br>
├── requirements.txt                 # 必要なPythonパッケージ<br>
├── nextflow                 # 解析ツール<br>
├── data/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── row_data/                    # ダウンロードされた元データが保存されるディレクトリ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── output_data/                 # FastQC解析結果が保存されるディレクトリ<br>
└── nextflow_conf/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── nextflow_merge_script.nf     # データマージ用Nextflowスクリプト<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── nextflow_run_script.nf       # 品質解析用Nextflowスクリプト<br>


# インストール

※コマンドはあくまで参考にしてください。必ずそれでインストールできるとは限りません。

## Javaのインストール

Nextflowの実行にはJavaが必要であるためインストールする。

**macOS**:
```zsh
brew install openjdk@17
```

**Ubuntu**:
```zh
sudo apt update
sudo apt install openjdk-17-jdk
```

## Pythonのインストール

Python3をインストールする。

**macOS**:
```zh
brew install python
```

**Ubuntu**:
```zh
sudo apt update
sudo apt install python3 python3-pip
```

## Nextflowのインストール
**macOS/Ubuntu**:
```zsh
curl -s https://get.nextflow.io
sudo mv nextflow /usr/local/bin/
```

## 必要なPythonパッケージのインストール
requirements.txtから必要なPythonパッケージをインストールする。
必要であれば仮想環境を使用する。
```zsh
# auto-appをクローンしたディレクトリに移動
pip install -r requirements.txt
```

# 実行
1. 作業ディレクトリに移動
```zsh
# 例
cd auto-app
```
2. 各パラメータを設定する
```auto.py
# プロジェクト番号を指定
project_accession = "ここに解析したいプロジェクト番号を指定する"

# シークエンスデータをダウンロードするディレクトリパスを指定
base_directory = "/自分の環境の絶対パスを入力/auto-app/data/row_data"

# Nextflowのパスを指定
nextflow_path = "/自分の環境の絶対パスを入力/auto-app/nextflow"

# nextflow_conf内の設定ファイルを指定
nextflow_merge_script = "/自分の環境の絶対パスを入力/auto-app/nextflow_conf/nextflow_merge_script.nf"
nextflow_run_script = "/自分の環境の絶対パスを入力/auto-app/nextflow_conf/nextflow_run_script.nf"

# 出力データの保存先を指定
output_directory = "/自分の環境の絶対パスを入力/auto-app/data/output_data"
```
3. (必要であれば)仮想環境を有効にする
```bash
# 解析サーバー(~/media/test/WD_BLACK)では以下のコマンドで仮想環境を有効化できる
pyenv activate auto_env
```

4. python3で実行する
```zsh
python3 auto.py
```