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
