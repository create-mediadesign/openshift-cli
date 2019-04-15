FROM frolvlad/alpine-glibc:latest

MAINTAINER René Groß <rene.gross@create.at>

ENV OC_VERSION=v3.7.2 \
    OC_TAG_SHA=282e43f \
    BUILD_DEPS='tar gzip' \
    RUN_DEPS='curl ca-certificates gettext zsh' \
    SHELL=/bin/zsh

RUN apk --no-cache add $BUILD_DEPS $RUN_DEPS && \
    curl -sLo /tmp/oc.tar.gz https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit.tar.gz && \
    tar xzvf /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit/oc /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit && \
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd && \
    apk del $BUILD_DEPS

CMD ["/usr/local/bin/oc"]
