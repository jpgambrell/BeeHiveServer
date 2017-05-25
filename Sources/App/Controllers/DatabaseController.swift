import Vapor
import HTTP
import PostgreSQL

enum DBTable  {
    enum user: String{
        case id
        case username
        case firstname
        case lastname
        case roleid
        case departmentid
    }
    enum department: String {
        case id
        case departmentname
    }
    enum form : String {
        case id
        case formname
        case formdescription
        case taskid
    }
    
    enum job : String {
        case id
        case jobname
        case jobdescription
        case managerid
        case workerid
        case statusid
        case startdate
        case enddate
        case completedate
    }
    enum question : String {
        case id
        case question
        case answer
        case formid
        case questiontypeid
    }
    enum questionoptions : String {
        case id
        case questionid
        case optionname
        case optionvalue
        case isvaluedefault
    }
    enum questiontype : String {
        case id
        case type
    }
    enum role : String {
        case id
        case rolename
        case roledescription
    }
    enum status : String{
        case id
        case type
    }
    enum task : String {
        case id
        case taskname
        case taskdescription
        case jobid
        case tasktypeid
        case statusid
        case step
        case startdate
        case enddate
        case completiondate
    }
    enum tasktype : String{
        case id
        case type
    }
}

struct user {
    var id : String?
    var username: String?
    var firstname: String?
    var lastname: String?
    var roleid: String?
    var departmentid: String?
    
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
