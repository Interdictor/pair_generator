FROM ruby:3.2.2-slim-buster AS base

ENV WORKPATH /opt/workdir/
ENV USERNAME servo
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --gid ${GROUP_ID} $USERNAME
RUN adduser --uid ${USER_ID} --gid ${GROUP_ID} --disabled-password --gecos '' $USERNAME

RUN apt-get update && apt-get -y install zlib1g-dev liblzma-dev patch gcc git make vim

WORKDIR $WORKPATH
RUN chown -R ${USER_ID}:${GROUP_ID} .

USER $USERNAME

COPY --chown=$USERNAME:$USERNAME Gemfile* $WORKPATH

CMD ["rspec"]

RUN bundle install
COPY --chown=$USERNAME:$USERNAME . $WORKPATH
