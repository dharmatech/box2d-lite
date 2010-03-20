
# Setup

    $ cd ~/scheme # Where '~/scheme' is the path to your Scheme libraries
    $ bzr branch lp:~scheme-libraries-team/scheme-libraries/srfi
    $ git clone git://github.com/dharmatech/dharmalab.git
    $ git clone git://github.com/dharmatech/agave.git

# Running the demos

## Run a demo in Ikarus

    $ ikarus --r6rs-script ~/scheme/box2d-lite/demos/small-pyramid.sps

## Run a demo in Chez

    $ scheme --program ~/scheme/box2d-lite/demos/small-pyramid.sps

## Run a demo in Larceny

    $ larceny --r6rs --program ~/scheme/box2d-lite/demos/small-pyramid.sps

# Notes

## Make a demo load faster in Ikarus

    $ ikarus --compile-dependencies ~/scheme/box2d-lite/demos/small-pyramid.sps

