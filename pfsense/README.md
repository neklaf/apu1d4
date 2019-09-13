Split pfSense image file into smaller files:
`$ split -b 48M pfSense-CE-memstick-serial-2.4.4-RELEASE-p3-amd64.img.gz "pfSense-CE-memstick-serial-2.4.4-RELEASE-p3-amd64.img.gz.part"`

Join small files to compose pfSense image file:
`$ cat pfSense-CE-memstick-serial-2.4.4-RELEASE-p3-amd64.img.gz.parta* >pfSense-CE-memstick-serial-2.4.4-RELEASE-p3-amd64.img.gz`
