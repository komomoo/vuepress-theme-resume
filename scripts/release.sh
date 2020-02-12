version=$(node -p "const { version } = require('./package.json'); version")

git checkout master

# build
yarn build

# commit
git add -A
standard-version --commit-all --release-as $version

# gh-pages
git checkout gh-pages
git merge master
git checkout master

# push
git push --tags origin
git push --all origin

# publish
npm publish --registry=https://registry.npmjs.org
