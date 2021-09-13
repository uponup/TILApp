import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    
    app.webSocket("echo") { (req, ws) in
        print("收到来自客户端的请求：\n\(req.content)")
        ws.send("我收到了你的消息")
    }
    
    // MARK: 注册路由的第一个种方式
    let acronymsController = AcronymsController()
    let usersController = UsersController()
    let catesController = CategoriesController()
    

//    app.get("api", "acronyms", use: acronymsController.getAllHandler)
    
    // MARK: 注册路由的第二种方式
    try app.register(collection: acronymsController)
    try app.register(collection: usersController)
    try app.register(collection: catesController)
    
    /**
    // MARK: Fluent复杂操作
    // 搜索
    app.get("api", "acronyms", "search") { (req) -> EventLoopFuture<[Acronym]> in
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }
        
        return Acronym.query(on: req.db).group(.or) { (or) in
            or.filter(\.$short == searchTerm)
            or.filter(\.$long == searchTerm)
        }.all()
    }
    
    // 查找第一个
    app.get("api", "acronyms", "first") { (req) -> EventLoopFuture<Acronym> in
        Acronym.query(on: req.db).first().unwrap(or: Abort(.notFound))
    }
    
    // 排序结果
    app.get("api", "acronyms", "sorted") { (req) -> EventLoopFuture<[Acronym]> in
        Acronym.query(on: req.db).sort(\.$short, .ascending).all()
    }
    
    
    
    // MARK: 数据库CRUD
    // 提交数据
    app.post("api", "acronyms") { (req) -> EventLoopFuture<Acronym> in
        let acronym = try req.content.decode(Acronym.self)
        
        return acronym.save(on: req.db).map {
            acronym
        }
    }
    // 获取所有数据
    app.get("api", "acronyms") { (req) -> EventLoopFuture<[Acronym]> in
        Acronym.query(on: req.db).all()
    }
    
    // 根据id获取一条数据
    app.get("api", "acronyms", ":acronymID") { (req) -> EventLoopFuture<Acronym> in
        Acronym.find(req.parameters.get("acronymID"), on: req.db).unwrap(or: Abort(.notFound))
    }
    // 修改
    app.put("api", "acronyms", ":acronymID") { (req) -> EventLoopFuture<Acronym> in
        let updatedAcronym = try req.content.decode(Acronym.self)
        return Acronym.find(req.parameters.get("acronymID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { acronym in
            acronym.short = updatedAcronym.short
            acronym.long = updatedAcronym.long
            return acronym.save(on: req.db).map {
                acronym
            }
        }
        
    }
    // 删除
    app.delete("api", "acronyms", ":acronymID") { (req) -> EventLoopFuture<HTTPStatus> in
        Acronym.find(req.parameters.get("acronymID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { acronym in
            acronym.delete(on: req.db).transform(to: .noContent)
        }
    }
 
     */
}
