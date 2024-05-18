import Vapor

struct KategoriaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let kategorieRoute = routes.grouped("kategorie")
        kategorieRoute.post(use: create)
        kategorieRoute.get(use: getAll)
    }

    func create(req: Request) throws -> EventLoopFuture<Kategoria> {
        let kategoria = try req.content.decode(Kategoria.self)
        return kategoria.save(on: req.db).map { kategoria }
    }

    func getAll(req: Request) throws -> EventLoopFuture<[Kategoria]> {
        Kategoria.query(on: req.db).all()
    }
}
