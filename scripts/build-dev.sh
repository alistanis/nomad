#!/usr/bin/env bash
set -e

GIT_COMMIT="$(git rev-parse HEAD)"
GIT_DIRTY="$(test -n "`git status --porcelain`" && echo "+CHANGES" || true)"
LDFLAG="main.GitCommit=${GIT_COMMIT}${GIT_DIRTY}"

TAGS="nomad_test"
if [[ $(uname) == "Linux" ]]; then
	if pkg-config --exists lxc; then
		TAGS="$TAGS lxc"
	fi
fi

echo "--> Installing with tags: $TAGS"
go install -ldflags "-X $LDFLAG" -tags "${TAGS}"
