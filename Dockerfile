FROM elixir:1.12-alpine

ENV MIX_ENV dev

RUN mkdir -p /opt/app && \
    chmod -R 777 /opt/app

WORKDIR /app

COPY . /app

RUN mix do local.hex --force, local.rebar --force

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

RUN mix do deps.get, deps.compile

WORKDIR /app
