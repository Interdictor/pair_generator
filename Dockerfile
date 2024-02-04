FROM ruby:3.2.2-slim-buster AS base

ENV WORKPATH /opt/workdir/
ENV USERNAME servo
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --gid ${GROUP_ID} $USERNAME
RUN adduser --uid ${USER_ID} --gid ${GROUP_ID} --disabled-password --gecos '' $USERNAME

WORKDIR $WORKPATH
RUN chown -R ${USER_ID}:${GROUP_ID} .

COPY --chown=$USERNAME:$USERNAME Gemfile* $WORKPATH
USER $USERNAME
RUN bundle install
COPY --chown=$USERNAME:$USERNAME . $WORKPATH

CMD ["ruby", "src/main.rb"]
