FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    pandoc \
    wkhtmltopdf \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /resume

ARG RESUME_FILE=resume.md
ARG OUTPUT_NAME=resume

COPY style.css ./
COPY ${RESUME_FILE} resume.md

RUN pandoc resume.md \
    -t html -f markdown \
    -c style.css --self-contained \
    -o resume.html && \
    xvfb-run --auto-servernum wkhtmltopdf \
    --enable-local-file-access \
    resume.html resume.pdf

ENV OUTPUT_NAME=${OUTPUT_NAME}

CMD ["sh", "-c", "cp resume.html /out/${OUTPUT_NAME}.html && cp resume.pdf /out/${OUTPUT_NAME}.pdf"]
