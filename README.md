# Naka.ma Web App

##Setup and Dependencies

Edit `/etc/hosts` and add this line:

    127.0.0.1 localhost.naka.ma

Run install commands below for services you do not have:

    brew install node
    brew install redis

Next clone the repo:

    git clone git@github.com:nakama/web-app.git

Now install the repo's dependencies:

    npm install -g brunch forever supervisor
    npm install

##Start the web app

    bin/dev_start

View the website at: [http://localhost.naka.ma:3001](http://localhost.naka.ma:3001)

##Auto-build changes to web app

    brunch w
