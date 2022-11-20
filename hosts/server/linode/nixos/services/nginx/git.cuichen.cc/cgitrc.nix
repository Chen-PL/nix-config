cgitPkg: ''
# Enable caching of up to 1000 output entriess
cache-size=1000

# Specify some default clone urls using macro expansion
clone-url=git://git.cuichen.cc/$CGIT_REPO_URL git@git.cuichen.cc:$CGIT_REPO_URL

# Specify the css url
css=/cgit.css

# Show extra links for each repository on the index page
enable-index-links=1

# Enable ASCII art commit history graph on the log pages
enable-commit-graph=1

# Show number of affected files per commit on the log pages
enable-log-filecount=1

# Show number of added/removed lines per commit on the log pages
enable-log-linecount=1

# Add a cgit favicon
favicon=/favicon.ico

# Use a custom logo
# logo=/img/mylogo.png

# Enable statistics per week, month and quarter
max-stats=quarter

# Set the title and heading of the repository index page
root-title=Chen's Git Repositories

# Set a subheading for the repository index page
root-desc=My personal projects

# Include some more info about example.com on the index page
# root-readme=/var/www/htdocs/about.html

# Allow download of tar.gz, tar.bz2 and zip-files
snapshots=tar.gz tar.bz2 zip

##
## List of common mimetypes
##

mimetype.gif=image/gif
mimetype.html=text/html
mimetype.jpg=image/jpeg
mimetype.jpeg=image/jpeg
mimetype.pdf=application/pdf
mimetype.png=image/png
mimetype.svg=image/svg+xml

source-filter=${cgitPkg}/lib/cgit/filters/syntax-highlighting.py

virtual-root=/
include=${./cgitrepos}
footer=${./footer.html}
''
