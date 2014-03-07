# Crate - a rails work sample

[![Build Status](https://travis-ci.org/ingobecker/crate.png?branch=master)](https://travis-ci.org/ingobecker/crate)

## Overview

This rails application comprises a virtual music collection to organize 
all your albums just like a vinyl crate(hence the name "crate").

It offers the following features:

* create a user account
* create own albums
* add tracks to own albums
* add cover-image to a album (displayed as thumbnail and larger version)
* add existing albums from other users to the own crate
* remove / edit albums inside own crate
* browse albums of all users
* browse only own albums
* fulltext-search with autocompletion
* restricted search inside own albums

The app was developed and tested using Archlinux.
Due to a lack of access to proprietary operating-systems
i can only assure proper operation on above-named systems
and the like.

## Runtime requirements

This rails app has the following runtime-dependencies:

* elasticsearch
* postgresql
* imagemagick

Make sure you have them running before starting the app.
This app doesn't ship with a secret_key_base in place.
Instead it uses a env variable called SECRET_TOKEN.
Use the following line to run the dev server and create 
a secret token on the fly:

    SECRET_TOKEN=$(rake secret) rails s

For having a more persistent secret token during a dev session
just do something like this:

    export SECRET_TOKEN=$(rake secret)

Now use `rails s` as usual. The secret token will expire once the
shell is closed.

## Running the application

Run the seeds to populate the database with dummy-data. To easily
tryout the functionality of this application, running the seeds
will also create a test-user with the following credentials:

    username: ingo@orgizm.net
    password: foobarbaz

## Tests

This app comprises several kinds of tests. To successfully run
the tests, make sure you have the following dependencies installed:

* phantomjs
* elasticsearch
* postgresql
* imagemagick

Make sure elasticsearch- as well as postgresql-daemon is running
during test execution.

As for the development server use the following line to run the tests:

    SECRET_TOKEN=$(rake secret) rake
