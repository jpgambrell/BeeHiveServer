import Foundation
import Vapor
import HTTP


struct JobPostSQLStatements {
    var insertjob: String
    var inserttask: String
    var insertform: String
    var insertquestion: String
    var insertquestionoption: String
    
    
    init(drop: Droplet) {
        let configFilename = "jobmanagerpost-sqlstatements"
        insertjob = drop.config[configFilename, "insertjob"]?.string ?? ""
        inserttask = drop.config[configFilename, "inserttask"]?.string ?? ""
        insertform = drop.config[configFilename, "insertform"]?.string ?? ""
        insertquestion = drop.config[configFilename, "insertquestion"]?.string ?? ""
        insertquestionoption = drop.config[configFilename, "insertquestionoption"]?.string ?? ""
    }
}

final class JobManagerPostController{
    let drop: Droplet
    let database: DatabaseController
    let sql: JobPostSQLStatements
    
    init(drop: Droplet){
        self.drop = drop
        self.database = DatabaseController(drop: drop)
        self.sql = JobPostSQLStatements(drop: drop)
    }
    
    func addRoutesToDrop(){
        let v1 = drop.grouped("v1","jobmanager")
        
        v1.post("addjob") { (request)  in
            return try self.addJob(request: request)
        }
        v1.post("addtask") { (request)  in
            return try self.addTask(request: request)
        }
        v1.post("addform") { (request)  in
            return try self.addForm(request: request)
        }
        v1.post("addquestion") { (request)  in
            return try self.addQuestion(request: request)
        }
        v1.post("addquestionoption") { (request)  in
            return try self.addQuestionOption(request: request)
        }
    }
    
    
    func addJob(request: Request) throws -> ResponseRepresentable {
        guard let jobname = request.data["jobname"]?.string,
            let jobdescription = request.data["jobdescription"]?.string,
            let managerid = request.data["managerid"]?.string,
            let workerid = request.data["workerid"]?.string,
            let statusid = request.data["statusid"]?.string,
            let startdate = request.data["startdate"]?.string,
            let enddate = request.data["enddate"]?.string,
            let completedate = request.data["completedate"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertjob.replacingOccurrences(of: ":1", with: jobname)
            .replacingOccurrences(of: ":2", with: jobdescription)
            .replacingOccurrences(of: ":3", with: managerid)
            .replacingOccurrences(of: ":4", with: workerid)
            .replacingOccurrences(of: ":5", with: statusid)
            .replacingOccurrences(of: ":6", with: startdate)
            .replacingOccurrences(of: ":7", with: enddate)
            .replacingOccurrences(of: ":8", with: completedate)
            .replacingOccurrences(of: "'NULL'", with: "NULL")
        
        let result = try database.execute(sql: preparedSQL)
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addTask(request: Request) throws -> ResponseRepresentable {
        guard let taskname = request.data["taskname"]?.string,
            let taskdescription = request.data["taskdescription"]?.string,
            let jobid = request.data["jobid"]?.string,
            let tasktypeid = request.data["tasktypeid"]?.string,
            let statusid = request.data["statusid"]?.string,
            let step = request.data["step"]?.string,
            let startdate = request.data["startdate"]?.string,
            let enddate = request.data["enddate"]?.string,
            let completedate = request.data["completedate"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.inserttask.replacingOccurrences(of: ":1", with: taskname)
            .replacingOccurrences(of: ":2", with: taskdescription)
            .replacingOccurrences(of: ":3", with: jobid)
            .replacingOccurrences(of: ":4", with: tasktypeid)
            .replacingOccurrences(of: ":5", with: statusid)
            .replacingOccurrences(of: ":6", with: step)
            .replacingOccurrences(of: ":7", with: startdate)
            .replacingOccurrences(of: ":8", with: enddate)
            .replacingOccurrences(of: ":9", with: completedate)
            .replacingOccurrences(of: "'NULL'", with: "NULL")
        
        let result = try database.execute(sql: preparedSQL)
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addForm(request: Request) throws -> ResponseRepresentable {
        guard let formname = request.data["formname"]?.string,
            let formdescription = request.data["formdescription"]?.string,
            let taskid = request.data["taskid"]?.string
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertform.replacingOccurrences(of: ":1", with: formname)
            .replacingOccurrences(of: ":2", with: formdescription)
            .replacingOccurrences(of: ":3", with: taskid)
        let result = try database.execute(sql: preparedSQL)
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    func addQuestion(request: Request) throws -> ResponseRepresentable {
        guard let question = request.data["question"]?.string,
            let answer = request.data["answer"]?.string,
            let formid = request.data["formid"]?.string,
            let questiontypeid = request.data["questiontypeid"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertquestion.replacingOccurrences(of: ":1", with: question)
            .replacingOccurrences(of: ":2", with: answer)
            .replacingOccurrences(of: ":3", with: formid)
            .replacingOccurrences(of: ":4", with: questiontypeid)
        
        
        let result = try database.execute(sql: preparedSQL)
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
    func addQuestionOption(request: Request) throws -> ResponseRepresentable {
        guard let questionid = request.data["questionid"]?.string,
            let optionname = request.data["optionname"]?.string,
            let optionvalue = request.data["optionvalue"]?.string,
            let isvaluedefault = request.data["isvaluedefault"]?.string
            
            else {
                throw Abort.badRequest
        }
        
        let preparedSQL = sql.insertquestionoption.replacingOccurrences(of: ":1", with: questionid)
            .replacingOccurrences(of: ":2", with: optionname)
            .replacingOccurrences(of: ":3", with: optionvalue)
            .replacingOccurrences(of: ":4", with: isvaluedefault)
        
        
        let result = try database.execute(sql: preparedSQL)
        
        return try Response(status: .created, json: JSON(node: [
            "result": result
            ]))
    }
    
}

