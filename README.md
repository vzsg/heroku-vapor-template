<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="Heroku API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.2-brightgreen.svg" alt="Swift 4.2">
    </a>
</p>

# Using the template

1. Clone the template
    
    ```bash
    # You can use either the Vapor Toolbox, or just git clone directly.

    $ vapor new YourApp --template=vzsg/heroku-vapor-template
    
    # Or:
    
    $ git clone https://github.com/vzsg/heroku-vapor-template YourApp
    $ cd YourApp
    $ rm -rf .git           # detach folder from template repo
    $ git init              # start new Git repo
    # Optional:  edit Package.swift - change "VaporApp" to whatever you like
    ```
    
1. Create a Heroku application

    ```bash
    # Append --region=eu if you want to use the EU region
    $ heroku apps:create your-heroku-app-name
    ```

1. Set up buildpack

    ```bash
    $ heroku buildpacks:set vapor/vapor
    ```
    
1. Add a free database

    ```bash
    $ heroku addons:create heroku-postgresql:hobby-dev
    ```
    
1. Commit and push

    ```bash
    $ git add .
    $ git commit -m "Initial commit"
    $ git push heroku master

1. Test if it's working

    ```bash
    $ heroku open
    ```
    
# Changes from the original api-template

- PostgreSQL is used instead of SQLite, which is configured with the `DATABASE_URL` environment variable if provided. The configuration is compatible with both the free and paid plans of Heroku Postgres.
- The provided Procfile ensures that all required command line parameters are passed to the app.
- The HSTSMiddleware automatically redirects HTTP calls to their HTTPS equivalents.
