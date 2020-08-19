# How to set up statping on Clever Cloud

1. create a new NodeJs application linked to a fork of this repo
2. create your database add-on on clever cloud and link it to the application
3. in your application environment variables you should now see the info you need to connect to your db
4. in your application environment variables add ```STATPING_HOST=statping.example.com``` (by default, it's going to fallback on the .cleverapps.io domain, but don't use the cleverapps domain in production)
5. in your application environment variables add ```STATPING_API_SECRET=<SOME RANDOM STRING>``` (Mandatory !!!)
6. in your application environment variables add ```STATPING_VERSION=0.90.61``` (Mandatory !!!)
7. you can now build and start the application

# How it works

1. create a new repo with a package.json with at least:
    ```
{
    "name": "statping-clever-cloud",
    "version": "1.0.0",
    "description": "statping on clevercloud",
    "scripts" : {
        "start" : "./run.sh"
    },
    "author": "Loic Tosser <wowi42>",
    "license": "ISC",
    "bugs": {
        "url": "https://github.com/wowi42/statping-clever-cloud/issues"
    },
    "homepage": "https://github.com/wowi42/statping-clever-cloud#readme",
    "engines": {
        "node": "^14"
    }
}
    ```
2. then create the start script.
3. in the start script put:
    ```
    #!/bin/bash
    set -e
    set -x
    cat
	export STATPING_BASIC_AUTH_ACTIVE=true
    export STATPING_PORT=$PORT
    export STATPING_PROTOCOL=https
    export DB_TYPE=postgresdb
    export DB_POSTGRESDB_DATABASE=$POSTGRESQL_ADDON_DB
    export DB_POSTGRESDB_HOST=$POSTGRESQL_ADDON_HOST
    export DB_POSTGRESDB_PORT=$POSTGRESQL_ADDON_PORT
    export DB_POSTGRESDB_USER=$POSTGRESQL_ADDON_USER
    export DB_POSTGRESDB_PASSWORD=POSTGRESQL_ADDON_PASSWORD
    export DB_POSTGRESDB_SCHEMA=statping
    ./node_modules/.bin/statping start
    ```
4. statping is now ready to start
