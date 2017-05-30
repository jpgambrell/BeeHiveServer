import Foundation
import Vapor
import HTTP


struct JobSQLStatements {
    var jobsByManager: String
    var jobTasksByManager: String
    var jobsByWorker: String
    var jobTasksByWorker: String
    var formQuestions: String
    var questionOption: String
    
    init(drop: Droplet) {
        let configFilename = "jobmanager-sqlstatements"
        self.jobsByManager = drop.config[configFilename, "jobsbymanager"]?.string ?? ""
        self.jobTasksByManager = drop.config[configFilename, "jobtaskbymanager"]?.string ?? ""
        self.jobsByWorker = drop.config[configFilename, "jobsbyworker"]?.string ?? ""
        self.jobTasksByWorker = drop.config[configFilename, "jobtaskbyworker"]?.string ?? ""
        self.formQuestions = drop.config[configFilename, "getformquestions"]?.string ?? ""
        self.questionOption = drop.config[configFilename, "getformquestionoption"]?.string ?? ""
    }
}

final class JobManagerGetController{
    let drop: Droplet
    let database: DatabaseController
    let sql: JobSQLStatements
    
    init(drop: Droplet){
        self.drop = drop
        self.database = DatabaseController(drop: drop)
        self.sql = JobSQLStatements(drop: drop)
    }
    
     func addRoutesToDrop(){
        let v1 = drop.grouped("v1","jobmanager")
        
        //Manager role
      
        v1.get("getjobsbymanager", String.parameter, handler: self.getJobsByManager)
        v1.get("getjobtasksbymanager", String.parameter, handler: self.getJobTasksByManager)
        
        //Worker role
        v1.get("getjobsbyworker", String.parameter, handler: self.getJobsByWorker)
        v1.get("getjobtasksbyworker", String.parameter, handler: self.getJobTasksByWorker)
        
        //Forms
        v1.get("getformquestions", String.parameter, handler: self.getFormQuestions)
        v1.get("getformquestionoptions", String.parameter, handler: self.getFormQuestionOptions)
        
        }
    
    
    //Route Handlers
    //Manager role
    func getJobsByManager(req: Request)  throws -> ResponseRepresentable {
        let managerid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobsByManager.replacingOccurrences(of: ":1", with: managerid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    func getJobTasksByManager(req: Request)  throws -> ResponseRepresentable {
        let managerid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobTasksByManager.replacingOccurrences(of: ":1", with: managerid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }

    //Worker role
    func getJobsByWorker(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobsByWorker.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    
    func getJobTasksByWorker(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobTasksByWorker.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    
    //Forms
    func getFormQuestions(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.formQuestions.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    func getFormQuestionOptions(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.questionOption.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
}

