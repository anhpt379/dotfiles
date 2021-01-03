FROM ubuntu:21.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y --no-install-recommends  \
    ca-certificates locales \
    wget curl httpie \
    build-essential musl-tools \
    fish git neovim python3 \
    fzf fd-find && \
  rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN wget https://github.com/gokcehan/lf/releases/download/r18/lf-linux-amd64.tar.gz && \
  tar zxvf lf-linux-amd64.tar.gz && \
  mv lf /usr/local/bin/ && \
  rm -f lf-linux-amd64.tar.gz

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH \
  RUST_VERSION=1.49.0

RUN rustArch='x86_64-unknown-linux-gnu'; \
  rustupSha256='ed7773edaf1d289656bdec2aacad12413b38ad0193fff54b2231f5140a4b07c5' ; \
  url="https://static.rust-lang.org/rustup/archive/1.23.1/${rustArch}/rustup-init"; \
  wget "$url"; \
  echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
  chmod +x rustup-init; \
  ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
  rm rustup-init; \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
  rustup --version; \
  cargo --version; \
  rustc --version;

RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install devicon-lookup exa bat --target x86_64-unknown-linux-musl

# RUN curl -k -L https://get.oh-my.fish | fish
RUN useradd -s /bin/fish -m anh
USER anh

RUN curl -k -L https://get.oh-my.fish > /tmp/install && \
  fish /tmp/install --path=~/.local/share/omf --config=~/.config/omf --noninteractive --yes && \
  rm -f /tmp/install
