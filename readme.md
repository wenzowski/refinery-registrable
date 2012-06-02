[![Build Status](https://secure.travis-ci.org/wenzowski/refinery-registrable.png?branch=dev)](http://travis-ci.org/wenzowski/refinery-registrable)


##Purpose

*refinery-registrable* exists to allow front-end registration on Refinery CMS powered websites.

##Gem Versioning

This gem matches version numbering with the Refinery CMS distribution it is intended for.

##Testing

Generate the testing app with `$ bundle exec rake refinery:testing:dummy_app`

If you're regenerating the testing app you should `$ rm -r spec/dummy` first or strange things will happen.

Run the tests with `$ bundle exec rspec ./spec`

##Committing

*refinery-registrable* uses [Travis CI] to perform [continuous integration].

Each commit pushed to github will be automatically tested unless the commit message includes `[ci skip]`


  [Travis CI]: http://about.travis-ci.org/docs/
  [continuous integration]: http://en.wikipedia.org/wiki/Continuous_integration
