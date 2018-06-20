FROM fedora:28

RUN dnf -y update && \
    dnf install -y dnf-plugins-core &&  \
    dnf -y copr enable srakitnican/gimp-2.10 &&  \
    dnf install -y gimp && \
    dnf clean all

CMD /usr/bin/gimp
