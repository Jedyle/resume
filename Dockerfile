FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    pandoc \
    wkhtmltopdf \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /resume

COPY resume.md style.css ./

RUN pandoc resume.md \
    -t html -f markdown \
    -c style.css --self-contained \
    -o resume.html && \
    xvfb-run --auto-servernum wkhtmltopdf \
    --enable-local-file-access \
    resume.html resume.pdf

CMD ["sh", "-c", "cp resume.html resume.pdf resume.md /out/"]
