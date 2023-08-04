#!/bin/bash

# Required since https://github.blog/2022-04-12-git-security-vulnerability-announced
git config --global --add safe.directory $GITHUB_WORKSPACE

TOKEN_DEPRECATED_WARNING_MESSAGE="⚠ This action will stop working with the next future major version of firebase-tools! Migrate to Service Account. See more: https://github.com/wzieba/Firebase-Distribution-Github-Action/wiki/FIREBASE_TOKEN-migration"

if [ -n "${INPUT_SERVICECREDENTIALSFILE}" ] ; then
    export GOOGLE_APPLICATION_CREDENTIALS="${INPUT_SERVICECREDENTIALSFILE}"
fi

if [ -n "${INPUT_SERVICECREDENTIALSFILECONTENT}" ] ; then
    cat <<< "${INPUT_SERVICECREDENTIALSFILECONTENT}" > service_credentials_content.json
    export GOOGLE_APPLICATION_CREDENTIALS="service_credentials_content.json"
fi

if [ -n "${INPUT_TOKEN}" ] ; then
    echo ${TOKEN_DEPRECATED_WARNING_MESSAGE}
    export FIREBASE_TOKEN="${INPUT_TOKEN}"
fi

output=$(firebase \
        crashlytics:dsymbols:upload \        
        --app "$INPUT_APPID" \
        "$INPUT_FILE")

status=$?

echo $output

if [ -n "${INPUT_TOKEN}" ] ; then
    echo ${TOKEN_DEPRECATED_WARNING_MESSAGE}
fi

exit $status
