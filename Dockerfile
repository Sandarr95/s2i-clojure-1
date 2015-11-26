
# s2i-clojure-centos7
FROM openshift/base-centos7

MAINTAINER Tobias Florek <tob@butter.sh>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV CLOJURE_VERSION 1.5.1
ENV OPENJDK_VERSION 1.8.0
ENV LEININGEN_INSTALLER_URL https://raw.github.com/technomancy/leiningen/stable/bin/lein

LABEL io.k8s.description="Platform for building clojure apps" \
      io.k8s.display-name="clojure $CLOJURE_VERSION builder" \
      io.openshift.expose-services="" \
      io.openshift.tags="builder,clojure"

RUN yum install -y --setopt=tsflags=nodocs \
        java-$OPENJDK_VERSION-openjdk-devel \
	clojure-$CLOJURE_VERSION \
        sudo \
 && yum clean all -y \
 && curl -Lo /usr/bin/lein $LEININGEN_INSTALLER_URL \
 && chmod +x /usr/bin/lein \
 && sudo -u 1001 'lein version'

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/local/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
# COPY ./.s2i/bin/ /usr/local/s2i
# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["usage"]
