#!/bin/bash

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"



echo ℹ️ tsc version: "$(npx tsc --version)"

echo "::group::📝 Running tsc with reviewdog 🐶 ..."

# shellcheck disable=SC2086
npx tsc ${INPUT_TSC_FLAGS} |
  reviewdog -f=tsc \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    -level="${INPUT_LEVEL}" \
    ${INPUT_REVIEWDOG_FLAGS}

reviewdog_rc=$?
echo "::endgroup::"
exit $reviewdog_rc
