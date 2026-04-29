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
