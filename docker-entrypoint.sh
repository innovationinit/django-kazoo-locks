#!/bin/bash

exec "$@"
set -e

if [ ${CI_JOB_NAME} == 'release' ]
then
  # Do release
  python setup.py sdist
  # Check if version exists
  set +e
  wget --http-user=$TWINE_USERNAME --http-password=$TWINE_PASSWORD -O package_index.html $TWINE_REPOSITORY_URL/$PYPI_PACKAGE_NAME/
  if [ $? -eq 0 ]
  then
    for filepath in dist/*; do
      filename=`basename $filepath`
      grep $filename package_index.html
      if [ $? -eq 0 ]
      then
        echo "Package $filename already uploaded!"
        exit 1;
      fi
    done
  fi
  set -e
  twine upload dist/*
else
  # By default do test
  tox
fi
