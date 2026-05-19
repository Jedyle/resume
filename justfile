default:
	just --list

build:
    mkdir -p out
    cp resume.md resume.md.bak
    sed "s/__PHONE_ENTRY__//" resume.md.bak > resume.md
    docker build -t resume-builder . && docker run --rm -v "$(pwd)/out:/out" resume-builder; \
    mv resume.md.bak resume.md

build-private phone:
    mkdir -p out
    cp resume.md resume.md.bak
    sed "s/__PHONE_ENTRY__/ - [ {{phone}} ]/" resume.md.bak > resume.md
    head resume.md
    docker build -t resume-builder . && docker run --rm -v "$(pwd)/out:/out" resume-builder; \
    mv resume.md.bak resume.md

build-devops:
    mkdir -p out
    sed "s/__PHONE_ENTRY__//" resume-devops.md > resume-devops.tmp.md
    docker build -t resume-builder-devops \
        --build-arg RESUME_FILE=resume-devops.tmp.md \
        --build-arg OUTPUT_NAME=resume-devops . && \
    docker run --rm -v "$(pwd)/out:/out" resume-builder-devops; \
    rm resume-devops.tmp.md

build-private-devops phone:
    mkdir -p out
    sed "s/__PHONE_ENTRY__/ - [ {{phone}} ]/" resume-devops.md > resume-devops.tmp.md
    docker build -t resume-builder-devops \
        --build-arg RESUME_FILE=resume-devops.tmp.md \
        --build-arg OUTPUT_NAME=resume-devops . && \
    docker run --rm -v "$(pwd)/out:/out" resume-builder-devops; \
    rm resume-devops.tmp.md

build-mlops:
    mkdir -p out
    sed "s/__PHONE_ENTRY__//" resume-mlops.md > resume-mlops.tmp.md
    docker build -t resume-builder-mlops \
        --build-arg RESUME_FILE=resume-mlops.tmp.md \
        --build-arg OUTPUT_NAME=resume-mlops . && \
    docker run --rm -v "$(pwd)/out:/out" resume-builder-mlops; \
    rm resume-mlops.tmp.md

build-private-mlops phone:
    mkdir -p out
    sed "s/__PHONE_ENTRY__/ - [ {{phone}} ]/" resume-mlops.md > resume-mlops.tmp.md
    docker build -t resume-builder-mlops \
        --build-arg RESUME_FILE=resume-mlops.tmp.md \
        --build-arg OUTPUT_NAME=resume-mlops . && \
    docker run --rm -v "$(pwd)/out:/out" resume-builder-mlops; \
    rm resume-mlops.tmp.md

# Build any markdown file as a CV (public version, no phone number).
build-custom file output_dir="out":
    #!/usr/bin/env bash
    set -euo pipefail
    name=$(basename "{{file}}" .md)
    abs_file="$(realpath "{{file}}")"
    abs_output="$(realpath -m "{{output_dir}}")"
    mkdir -p "${abs_output}"
    tmp_file="${name}-tmp.md"
    sed "s/__PHONE_ENTRY__//" "${abs_file}" > "${tmp_file}"
    docker build -t "resume-builder-custom" \
        --build-arg RESUME_FILE="${tmp_file}" \
        --build-arg OUTPUT_NAME="${name}" . && \
    docker run --rm -v "${abs_output}:/out" resume-builder-custom
    rm -f "${tmp_file}"
    echo "Built: ${abs_output}/${name}.pdf"

# Build any markdown file as a CV with phone number (private version for recruiters).
build-custom-private file phone output_dir="out":
    #!/usr/bin/env bash
    set -euo pipefail
    name=$(basename "{{file}}" .md)
    abs_file="$(realpath "{{file}}")"
    abs_output="$(realpath -m "{{output_dir}}")"
    mkdir -p "${abs_output}"
    tmp_file="${name}-tmp.md"
    sed "s/__PHONE_ENTRY__/ - [ {{phone}} ]/" "${abs_file}" > "${tmp_file}"
    docker build -t "resume-builder-custom" \
        --build-arg RESUME_FILE="${tmp_file}" \
        --build-arg OUTPUT_NAME="${name}" . && \
    docker run --rm -v "${abs_output}:/out" resume-builder-custom
    rm -f "${tmp_file}"
    echo "Built: ${abs_output}/${name}.pdf"
