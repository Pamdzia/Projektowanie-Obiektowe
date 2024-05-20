import Fluent
import Vapor

final class Produkt: Model, Content {
    static let schema = "produkty"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "nazwa")
    var nazwa: String

    @Field(key: "cena")
    var cena: Double

    @Parent(key: "kategoria_id")
    var kategoria: Kategoria

    init() {}

    init(id: UUID? = nil, nazwa: String, cena: Double, kategoriaID: UUID) {
        self.id = id
        self.nazwa = nazwa
        self.cena = cena
        self.$kategoria.id = kategoriaID
    }
}
