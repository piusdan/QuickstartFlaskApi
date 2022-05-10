ARG INSTALL_PYTHON_VERSION=${INSTALL_PYTHON_VERSION:-PYTHON_VERSION_NOT_SET}

# ========= BUILDER ===========================================================
FROM python:${INSTALL_PYTHON_VERSION}-slim-buster as builder

RUN pip install poetry

# ================================= PRODUCTION =================================
FROM builder as production

WORKDIR /www/root

RUN useradd -m sid
RUN chown -R sid:sid /www/root && chown -R sid:sid /usr/local
USER sid
ENV PATH="/home/sid/.local/bin:${PATH}"

COPY poetry.lock pyproject.toml ./
RUN poetry config virtualenvs.create false && poetry install --no-dev

COPY . .

EXPOSE 5000
ENTRYPOINT ["/bin/bash"]
CMD ["-c",  "shell_scripts/run.sh"]


# ================================= DEVELOPMENT ================================
FROM builder AS development

WORKDIR /www/root

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false && poetry install

COPY . .

ENV FLASK_APP=autoapp
ENV FLASK_DEBUG=1
ENV FLASK_ENV=development

COPY .env.example .env

EXPOSE 5000
ENTRYPOINT ["/bin/bash"]
CMD ["-c",  "flask run -h 0.0.0.0"]
