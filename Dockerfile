FROM registry.svc.ci.openshift.org/ocp/builder:rhel-8-golang-1.15-openshift-4.8 AS builder
WORKDIR /src
COPY . .
# FIXME once we can depend on a new enough host that supports globs for COPY,
# just use that.  For now we work around this by copying a tarball.
RUN make && make install DESTDIR=./instroot && tar -C instroot -cf instroot.tar .

FROM registry.svc.ci.openshift.org/ocp/4.8:base
COPY --from=builder /src/instroot.tar /tmp/instroot.tar
RUN cd / && tar xf /tmp/instroot.tar && rm -f /tmp/instroot.tar
# We're not really an operator, we're just getting some data into the release image.
LABEL io.openshift.release.operator=true

