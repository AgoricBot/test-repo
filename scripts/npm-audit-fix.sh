git clone https://github.com/AgoricBot/test-repo.git
cd test-repo

if npm audit ; then
    echo "Nothing to fix"
else
    git config user.email "kate+agoricbot@agoric.com"
    git config user.name "AgoricBot"
    git checkout -b npm-audit-fix
    npm audit fix
    git add . 
    git commit -m "results of running npm audit fix"
    git remote set-url origin https://AgoricBot:$GITHUB_TOKEN@github.com/AgoricBot/test-repo.git
    git push origin npm-audit-fix
    hub pull-request --no-edit --base Agoric/test-repo:master
fi

# Do the same thing with the package.json in the integration-test folder
cd integration-test
if npm audit ; then
    echo "Nothing to fix"
else
    git config user.email "kate+agoricbot@agoric.com"
    git config user.name "AgoricBot"
    git checkout -b npm-audit-fix
    sudo npm cache clean -f
    npm install
    npm ci
    npm audit fix
    git add . 
    git commit -m "results of running npm audit fix"
    git remote set-url origin https://AgoricBot:$GITHUB_TOKEN@github.com/AgoricBot/test-repo.git
    git push origin npm-audit-fix
    hub pull-request --no-edit --base Agoric/test-repo:master
fi
