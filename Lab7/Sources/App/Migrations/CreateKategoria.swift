import Fluent

struct CreateKategoria: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("kategorie")
            .id()
            .field("nazwa", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("kategorie").delete()
    }
}
