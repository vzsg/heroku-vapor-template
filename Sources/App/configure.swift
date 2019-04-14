import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    services.register(HSTSMiddleware())
    var middlewares = MiddlewareConfig()
    middlewares.use(HSTSMiddleware.self)
    middlewares.use(FileMiddleware.self)
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)

    // Create PostgreSQL configuration
    let _psqlConfig: PostgreSQLDatabaseConfig?

    if let databaseURL = ProcessInfo.processInfo.environment["DATABASE_URL"] {
        _psqlConfig = PostgreSQLDatabaseConfig(url: databaseURL, transport: .unverifiedTLS)
    } else {
        _psqlConfig = PostgreSQLDatabaseConfig(url: "postgres://root:root@localhost:5432/test")
    }

    guard let psqlConfig = _psqlConfig else {
        print("Failed to parse PostgreSQL URL!")
        fflush(stdout)
        fatalError()
    }

    let psql = PostgreSQLDatabase(config: psqlConfig)

    // Register the configured database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: psql, as: .psql)

    if ProcessInfo.processInfo.environment["DATABASE_QUERY_LOGGING"] == "true" {
        databases.enableLogging(on: .psql)
    }

    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .psql)
    services.register(migrations)
}
