import Fluent
import Vapor

final class Kategoria: Model, Content {
    static let schema = "kategorie"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "nazwa")
    var nazwa: String

    @Children(for: \.$kategoria)
    var produkty: [Produkt]

    init() { }

    init(id: UUID? = nil, nazwa: String) {
        self.id = id
        self.nazwa = nazwa
    }
}
