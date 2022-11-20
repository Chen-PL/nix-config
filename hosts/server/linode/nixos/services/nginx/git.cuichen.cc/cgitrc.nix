{
  # Enable caching of up to 1000 output entries
  cache-size = 1000;

  # Specify some default clone urls using macro expansion
  clone-url = "git://git.cuichen.cc/$CGIT_REPO_URL git@git.cuichen.cc:$CGIT_REPO_URL";

  # Specify the css url
  css = "/cgit.css";

  # Show owner on index page
  enable-index-owner = 0;

  # Allow http transport git clone
  enable-http-clone = 1;

  # Show extra links for each repository on the index page
  enable-index-links = 1;

  # Enable blame page and create links to it from tree page
  enable-blame = 1;

  # Enable ASCII art commit history graph on the log pages
  enable-commit-graph = 1;

  # Show number of affected files per commit on the log pages
  enable-log-filecount = 1;

  # Show number of added/removed lines per commit on the log pages
  enable-log-linecount = 1;

  # Sort branches by date
  branch-sort = "age";

  # Add a cgit favicon
  # favicon = /favicon.ico;

  # Use a custom logo
  # logo = /img/mylogo.png;

  # Enable statistics per week, month and quarter
  max-stats = "quarter";

  # Set the title and heading of the repository index page
  root-title = "Chen's Git Repositories";

  # Set a subheading for the repository index page
  root-desc = "My personal projects";

  # Include some more info about example.com on the index page
  # root-readme = /var/www/htdocs/about.html;

  # Allow download of tar.gz, tar.bz2 and zip-files
  snapshots = "tar.gz tar.bz2 zip";

  include = ./cgitrepos;

  footer = ''
    Powered by
    <a href="https://git.zx2c4.com/cgit/about/">cgit</a>,
    <a href="https://nginx.org/en/NGINX">NGINX</a> and
    <a href="https://nixos.org/">NixOS</a>.
  '';

  virtual-root = "/";
}
