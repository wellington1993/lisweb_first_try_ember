#!/bin/sh

# ember-simple-auth's routes/application.js conflicts with the routes/application.js
# that results from compilation of our routes/application.coffee.
# ESA's application route doesn't seem to be necessary.
# https://github.com/simplabs/ember-simple-auth/issues/851
echo "deleting ember-simple-auth's application route to workaround incompatibility with coffeescript..."
mv node_modules/ember-simple-auth/app/routes/application.js node_modules/ember-simple-auth/app/routes/application2.js 2>/dev/null
exit 0           
