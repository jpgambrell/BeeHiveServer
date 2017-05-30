import Foundation
import Vapor
import HTTP


struct HiveSetupPostSQLStatements {
    
    var insertDepartment: String
    var insertRole: String
    var insertUser: String
    var insertTaskType: String
    var insertQuestionType: String
    var insertStatusType: String
    
    init(drop: Droplet) {
        let configFilename = "hiveadminpost-sqlstatements"
        
        insertDepartment = drop.config[configFilename, "insertdepartment"]?.string ?? ""
        insertRole = drop.config[configFilename, "insertrole"]?.string ?? ""
        insertUser = drop.config[configFilename, "insertuser"]?.string ?? ""
        insertTaskType = drop.config[configFilename, "inserttasktype"]?.string ?? ""
        insertQuestionType = drop.config[configFilename, "insertquestiontype"]?.string ?? ""
        insertStatusType = drop.config[configFilename, "insertstatustype"]?.string ?? ""
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
        guard let userName = request.data["username"]?.string,
            let firstName = request.data["firstname"]?.string,
            let lastName = request.data["lastname"]?.string,
            let roleId = request.data["roleid"]?.string,
            let departmentId = request.data["departmentid"]?.string,
            let supervisorId = request.data["supervisorid"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertUser.replacingOccurrences(of: ":1", with: userName)
            .replacingOccurrences(of: ":2", with: firstName)
            .replacingOccurrences(of: ":3", with: lastName)
            .replacingOccurrences(of: ":4", with: roleId)
            .replacingOccurrences(of: ":5", with: departmentId)
            .replacingOccurrences(of: ":6", with: supervisorId)
        
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
        
        let preparedSQL = sql.insertDepartment.replacingOccurrences(of: ":1", with: department)
        
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
        
        let preparedSQL = sql.insertTaskType.replacingOccurrences(of: ":1", with: taskType)
        
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
        
        let preparedSQL = sql.insertRole.replacingOccurrences(of: ":1", with: roleName)
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
        
        let preparedSQL = sql.insertQuestionType.replacingOccurrences(of: ":1", with: questionType)
        
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
        
        let preparedSQL = sql.insertStatusType.replacingOccurrences(of: ":1", with: statusType)
        
        guard let result = try? database.execute(sql: preparedSQL) else{
            throw Abort(.serviceUnavailable, metadata: "Dept not able to be added")
        }
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))    }
    
    
}
