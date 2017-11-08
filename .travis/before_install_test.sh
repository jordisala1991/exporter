#!/usr/bin/env sh
set -ev

PHP_INI_DIR="$HOME/.phpenv/versions/$(phpenv version-name)/etc/conf.d/"
TRAVIS_INI_FILE="$PHP_INI_DIR/travis.ini"
if [ "$DOCTRINE_ODM" != "" ]
then
    composer require "doctrine/mongodb-odm:$DOCTRINE_ODM" --no-update
    echo "extension=mongodb.so" >> "$TRAVIS_INI_FILE"
fi

if [ "${TRAVIS_PHP_VERSION}" != "hhvm" ]; then
    echo "memory_limit=3072M" >> "$TRAVIS_INI_FILE"
fi

sed --in-place "s/\"dev-master\":/\"dev-${TRAVIS_COMMIT}\":/" composer.json

if [ "$SYMFONY" != "" ]; then composer require "symfony/symfony:$SYMFONY" --no-update; fi;
