FROM oven/bun:1.2.6

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y git bash-completion tree vim curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ホスト名の設定
RUN echo "mcp-dev" > /etc/hostname

# Gitのタブ補完有効化と__git_ps1コマンドの利用
RUN echo "source /usr/share/bash-completion/completions/git" >> /home/bun/.bashrc && \
    echo "if [ -f /etc/bash_completion.d/git-prompt ]; then source /etc/bash_completion.d/git-prompt; fi" >> /home/bun/.bashrc

# プロンプトの設定（ホスト名を固定）
RUN echo "PROMPT_COMMAND='PS1_CMD1=\$(__git_ps1 \" (%s)\")'; PS1='\[\e[38;5;40m\]\u@mcp-dev\[\e[0m\]:\[\e[38;5;39m\]\w\[\e[38;5;214m\]\${PS1_CMD1}\[\e[0m\]\\$ '" >> /home/bun/.bashrc

# デフォルトシェルをbashに設定
RUN chsh -s /bin/bash bun

# ホームディレクトリの所有権を確保
RUN chown -R bun:bun /home/bun

USER bun
WORKDIR /opt/app