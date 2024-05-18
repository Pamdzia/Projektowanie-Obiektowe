import Vapor

struct ProduktController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let produktyRoute = routes.grouped("produkty")
        produktyRoute.get(use: index)
        produktyRoute.post(use: create)
        produktyRoute.group(":produktID") { produkt in
            produkt.get(use: read)
            produkt.put(use: update)
            produkt.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Produkt]> {
        return Produkt.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Produkt> {
        let produkt = try req.content.decode(Produkt.self)
        return produkt.save(on: req.db).map { produkt }
    }

    func read(req: Request) throws -> EventLoopFuture<Produkt> {
        Produkt.find(req.parameters.get("produktID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func update(req: Request) throws -> EventLoopFuture<Produkt> {
        let updateData = try req.content.decode(Produkt.self)
        return Produkt.find(req.parameters.get("produktID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { produkt in
                produkt.nazwa = updateData.nazwa
                produkt.cena = updateData.cena
                produkt.$kategoria.id = updateData.$kategoria.id
                return produkt.save(on: req.db).map { produkt }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Produkt.find(req.parameters.get("produktID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { produkt in
                produkt.delete(on: req.db)
            }.transform(to: .ok)
    }
}
