# Docker image for gimp-2.10

to run the GUI:

    docker run -it --rm --net=host -e DISPLAY=$DISPLAY -v $HOME:/hosthome:ro -e XAUTHORITY=/hosthome/.Xauthority -w /hosthome bryanlarsen/gimp-2.10 

example batch script:

    docker run --rm -w /foo -v $(pwd):/foo bryanlarsen/gimp-2.10 gimp -i -d -f -b '(let* (
       (filename "in.jpg")
       (outfile "out.jpg")
       (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
       (drawable (car (gimp-image-get-active-layer image))))
      (gimp-image-convert-color-profile-from-file image "file:///foo/AdobeRGB1998.icc" 1 TRUE)
      (gimp-file-save RUN-NONINTERACTIVE image drawable outfile outfile)
      (gimp-image-delete image))' -b '(gimp-quit 0)'

## Dockerfile

```
FROM fedora:28

RUN dnf -y update && \
    dnf install -y dnf-plugins-core &&  \
    dnf -y copr enable srakitnican/gimp-2.10 &&  \
    dnf install -y gimp && \
    dnf clean all

CMD /usr/bin/gimp
```
