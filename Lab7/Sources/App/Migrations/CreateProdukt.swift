import Fluent

struct CreateProdukt: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("produkty")
            .id()
            .field("nazwa", .string, .required)
            .field("cena", .double, .required)
            .field("kategoria_id", .uuid, .required, .references("kategorie", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("produkty").delete()
    }
}
