ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-silverblue}"
ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"

COPY etc /etc

RUN wget https://copr.fedorainfracloud.org/coprs/david35mm/pamixer/repo/fedora-"${FEDORA_MAJOR_VERSION}"/david35mm-pamixer-fedora-"${FEDORA_MAJOR_VERSION}".repo -O /etc/yum.repos.d/_copr_david35mm-pamixer.repo
RUN wget https://copr.fedorainfracloud.org/coprs/nani8ot/river-git/repo/fedora-"${FEDORA_MAJOR_VERSION}"/nani8ot-river-git-fedora-"${FEDORA_MAJOR_VERSION}".repo -O /etc/yum.repos.d/_copr_nani8ot-river-git.repo

ADD build.sh /tmp/build.sh
ADD post-install.sh /tmp/post-install.sh
ADD packages.json /tmp/packages.json

COPY --from=ghcr.io/ublue-os/config:latest /rpms /tmp/rpms

RUN /tmp/build.sh && \
    rm -f /etc/yum.repos.d/_copr_david35mm-pamixer.repo && \
    rm -f /etc/yum.repos.d/_copr_nani8ot-river-git.repo
RUN /tmp/post-install.sh
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp
