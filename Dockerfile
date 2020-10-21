FROM elixir:latest

RUN apt-get update && apt-get install --yes postgresql-client
ADD . /app
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.4 --force
WORKDIR /app
EXPOSE 4000
CMD ["./entrypoint.sh"]