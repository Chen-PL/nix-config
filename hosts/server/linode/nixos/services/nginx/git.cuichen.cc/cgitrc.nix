cgitPkg: ''
virtual-root=/ # Required for Nginx

css=/cgit.css
favicon=/favicon.ico
logo=
footer=${./footer.html}
source-filter=${cgitPkg}/lib/cgit/filters/syntax-highlighting.py
about-filter=${cgitPkg}/lib/cgit/filters/about-formatting.sh
root-title=Chen's Git Repositories
root-desc=
noplainemail=1
robots=noindex, nofollow
readme=:README.md

clone-prefix=https://git.cuichen.cc

# Enable snapshots
snapshots=tar.gz tar.bz2 zip

# Disable owner index
enable-index-owner=0

mimetype.gif=image/gif
mimetype.html=text/html
mimetype.jpg=image/jpeg
mimetype.jpeg=image/jpeg
mimetype.pdf=application/pdf
mimetype.png=image/png
mimetype.svg=image/svg+xml

# Caching
cache-dynamic-ttl=60
cache-static-ttl=44640
cache-root-ttl=6
cache-repo-ttl=120

include=${./cgitrepos}
''
