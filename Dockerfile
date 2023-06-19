FROM python:3.11-slim-buster as base

RUN pip install pip==22.2.2
RUN pip install poetry==1.1.13

RUN useradd -u 1000 -m kip
USER kip
RUN mkdir /home/kip/src
WORKDIR /home/kip/src

COPY --chown=kip:kip pyproject.toml .
COPY --chown=kip:kip poetry.lock .

RUN poetry install -n -vvv --no-dev

COPY --chown=kip:kip main.py .
COPY --chown=kip:kip entrypoint.sh .


###############################################################################
# Test
###############################################################################
FROM base as test
ENTRYPOINT ["poetry", "run", "tox"]


###############################################################################
# Release
###############################################################################
FROM base as release
ENTRYPOINT ["poetry", "run", "python", "main.py"]
