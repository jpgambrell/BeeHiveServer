import Foundation
import Vapor
import HTTP


struct HiveSetupPostSQLStatements {
    
    var insertdepartment: String
    var insertrole: String
    var insertuser: String
    var inserttasktype: String
    var insertquestiontype: String
    var insertstatustype: String
    
    init(drop: Droplet) {
        let configFilename = "hiveadminpost-sqlstatements"
        
        insertdepartment = drop.config[configFilename, "insertdepartment"]?.string ?? ""
        insertrole = drop.config[configFilename, "insertrole"]?.string ?? ""
        insertuser = drop.config[configFilename, "insertuser"]?.string ?? ""
        inserttasktype = drop.config[configFilename, "inserttasktype"]?.string ?? ""
        insertquestiontype = drop.config[configFilename, "insertquestiontype"]?.string ?? ""
        insertstatustype = drop.config[configFilename, "insertstatustype"]?.string ?? ""
    }
}

final class HiveAdminPostController{
    let drop: Droplet
    let database: DatabaseController
    let sql: HiveSetupPostSQLStatements
    
    init(drop: Droplet){
        self.drop = drop
        database = DatabaseController(drop: drop)
        sql = HiveSetupPostSQLStatements(drop: drop)
    }
    
   
    
    func addRoutesToDrop(){
        let v1 = drop.grouped("v1","hiveadmin")
        
        v1.post("adduser") { (request)  in
            return try self.addUser(request: request)
        }
        v1.post("adddepartment") { (request)  in
            return try self.addDepartment(request: request)
        }
        v1.post("addrole") { (request)  in
            return try self.addRole(request: request)
        }
        v1.post("addtasktype") { (request)  in
            return try self.addTaskType(request: request)
        }
        v1.post("addquestiontype") { (request)  in
            return try self.addQuestionType(request: request)
        }
        v1.post("addstatustype") { (request)  in
            return try self.addStatusType(request: request)
        }
    }
    
    func addUser(request: Request) throws -> ResponseRepresentable {
        guard let username = request.data["username"]?.string,
            let firstname = request.data["firstname"]?.string,
            let lastname = request.data["lastname"]?.string,
            let roleid = request.data["roleid"]?.string,
            let departmentid = request.data["departmentid"]?.string,
            let supervisorid = request.data["supervisorid"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertuser.replacingOccurrences(of: ":1", with: username)
            .replacingOccurrences(of: ":2", with: firstname)
            .replacingOccurrences(of: ":3", with: lastname)
            .replacingOccurrences(of: ":4", with: roleid)
            .replacingOccurrences(of: ":5", with: departmentid)
            .replacingOccurrences(of: ":6", with: supervisorid)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "User not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addDepartment(request: Request) throws -> ResponseRepresentable {
        guard let department = request.data["department"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertdepartment.replacingOccurrences(of: ":1", with: department)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Dept not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addTaskType(request: Request) throws -> ResponseRepresentable {
        guard let taskType = request.data["tasktype"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.inserttasktype.replacingOccurrences(of: ":1", with: taskType)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Task not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))    }
    
    func addRole(request: Request) throws -> ResponseRepresentable {
        guard let roleName = request.data["rolename"]?.string,
            let roleDescription = request.data["roledescription"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertrole.replacingOccurrences(of: ":1", with: roleName)
            .replacingOccurrences(of: ":2", with: roleDescription)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Role not able to be saved")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addQuestionType(request: Request) throws -> ResponseRepresentable {
        guard let questionType = request.data["questiontype"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertquestiontype.replacingOccurrences(of: ":1", with: questionType)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Dept not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))    }
    
    func addStatusType(request: Request) throws -> ResponseRepresentable {
        guard let statusType = request.data["statustype"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertstatustype.replacingOccurrences(of: ":1", with: statusType)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Dept not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))    }
    
    
}
