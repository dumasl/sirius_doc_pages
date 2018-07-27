if [ -n "${GITHUB_sirius_doc_API_KEY}" ]; then
    cd "$TRAVIS_BUILD_DIR"
    docker run -v $HOME/sirius_doc_pages:/sirius_doc_pages ldumas/sirius_dockerfile:sirius /bin/sh -c "cd /sirius_doc_pages/sphinx; make html"
    cd $HOME/sphinx/build/html/
    git init
    git checkout -b gh-pages
    git add .
    git -c user.name='travis' -c user.email='travis' commit -m init
    # Make sure to make the output quiet, or else the API token will leak!
    # This works because the API key can replace your password.
    git push -f -q https://<me>:${GITHUB_sirius_doc_API_KEY}@github.com/dumasl/sirius_dockerfile-gh-pages gh-pages &2>/dev/null
    cd "$TRAVIS_BUILD_DIR"
fi
