import Vapor
import HTTP
import PostgreSQL

struct user {
    var id : String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var roleId: String?
    var departmentId: String?
    var supervisorId: String?
    
    func parseResult(result: Any) {
        
    }
    
}




final class DatabaseController{
    let host: String
    let user: String
    let password: String
    let database: String
    let postgreSQLDB: PostgreSQL.Database
    
    init(drop: Droplet){
        self.host = drop.config["postgresql", "host"]?.string ?? ""
        self.user = drop.config["postgresql", "user"]?.string ?? ""
        self.password = drop.config["postgresql", "password"]?.string ?? ""
        self.database = drop.config["postgresql", "database"]?.string ?? ""
        
        self.postgreSQLDB = try! PostgreSQL.Database(hostname: host, database: database, user: user, password: password)
    }

    public func execute(sql: String) throws -> JSON{
      print(sql)
       
        guard let result = try? postgreSQLDB.makeConnection().execute(sql) else {
            throw Abort.serverError
        }
        return try JSON(node:result.array)
    }
    
    public func responseFrom(sqlQuery: String) throws -> ResponseRepresentable{
        let result = try self.execute(sql: sqlQuery)
        return try JSON(node: ["result" : result])
    }
}
