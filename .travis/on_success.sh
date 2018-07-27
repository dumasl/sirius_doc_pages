if [ -n "${GITHUB_sirius_doc_API_KEY}" ]; then
    cd "$TRAVIS_BUILD_DIR"
    docker run -v $TRAVIS_BUILD_DIR/sphinx:/sphinx ldumas/sirius_dockerfile:sirius /bin/sh -c "cd /sphinx; make html"
    cd $TRAVIS_BUILD_DIR/sphinx/build/html/
    git init
    git checkout -b gh-pages
    git add .
    git -c user.name='travis' -c user.email='travis' commit -m init
    # Make sure to make the output quiet, or else the API token will leak!
    # This works because the API key can replace your password.
    git push -f -q https://dumasl:${GITHUB_sirius_doc_API_KEY}@github.com/dumasl/sirius_dockerfile-gh-pages gh-pages &2>/dev/null
    cd "$TRAVIS_BUILD_DIR"
fi

