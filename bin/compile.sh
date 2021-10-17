#!/usr/bin/env bash
# bin/compile <build-dir> <cache-dir> <env-dir>

# Prep the vars
BUILD_DIR=${1:-}
CACHE_DIR=${2:-}
ENV_DIR=${3:-}

mkdir -p "${CACHE_DIR}"

# Prep the output fn
tell() {
    echo "-----> $1"
}
indent() {
    echo "$1" | sed 's/^/       /'
}



# Build Google Credentials
# tell "Generating .profile.d file to generate google-credentials.json at startup"
# mkdir -p $BUILD_DIR/.profile.d
tell "Generating google-credentials.json"
CREDENTIALS=$(cat ${ENV_DIR}/GOOGLE_CREDENTIALS)
CRED_DEST=$(cat ${ENV_DIR}/GOOGLE_APPLICATION_CREDENTIALS)
echo "${CREDENTIALS}" > "/app/${CRED_DEST}"
# echo "echo ${CREDENTIALS@Q} > /app/${CRED_DEST@Q}" > $BUILD_DIR/.profile.d/google-credentials.sh
# chmod +x $BUILD_DIR/.profile.d/google-credentials.sh



# Download Java
tell "Downloading JRE binaries"
JRE_URL=$(cat ${ENV_DIR}/JRE_URL)
JRE_DEST=$(cat ${ENV_DIR}/JRE_DEST)
JRE_CACHE="${CACHE_DIR}/jre.tar.gz"
if [ ! -e "${JRE_CACHE}" ]; then
    curl -L# "${JRE_URL}" -o "${JRE_CACHE}"
fi
mkdir -p "${BUILD_DIR}/${JRE_DEST}"
tar -xzf "${JRE_CACHE}" -C "${BUILD_DIR}/${JRE_DEST}" --strip-components=1



# Download Java Compiler
tell "Downloading Eclipse Java compiler"
COMPILER_URL=$(cat ${ENV_DIR}/COMPILER_URL)
COMPILER_DEST=$(cat ${ENV_DIR}/COMPILER_DEST)
COMPILER_CACHE="${CACHE_DIR}/compiler.jar"
if [ ! -e "${COMPILER_CACHE}" ]; then
    curl -L# "${COMPILER_URL}" -o "${COMPILER_CACHE}"
fi
mkdir -p "${BUILD_DIR}/${COMPILER_DEST}"
cp "${COMPILER_CACHE}" "${BUILD_DIR}/${COMPILER_DEST}"