import Foundation
import Vapor
import HTTP


struct JobSQLStatements {
    var jobsbymanager: String
    var jobtaskbymanager: String
    var jobsbyworker: String
    var jobtaskbyworker: String
    var formquestions: String
    var questionoption: String
    
    init(drop: Droplet) {
        let configFilename = "jobmanager-sqlstatements"
        self.jobsbymanager = drop.config[configFilename, "jobsbymanager"]?.string ?? ""
        self.jobtaskbymanager = drop.config[configFilename, "jobtaskbymanager"]?.string ?? ""
        self.jobsbyworker = drop.config[configFilename, "jobsbyworker"]?.string ?? ""
        self.jobtaskbyworker = drop.config[configFilename, "jobtaskbyworker"]?.string ?? ""
        self.formquestions = drop.config[configFilename, "getformquestions"]?.string ?? ""
        self.questionoption = drop.config[configFilename, "getformquestionoption"]?.string ?? ""
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
        let preparedSQL = sql.jobsbymanager.replacingOccurrences(of: ":1", with: managerid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    func getJobTasksByManager(req: Request)  throws -> ResponseRepresentable {
        let managerid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobtaskbymanager.replacingOccurrences(of: ":1", with: managerid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }

    //Worker role
    func getJobsByWorker(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobsbyworker.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    
    func getJobTasksByWorker(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.jobtaskbyworker.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    
    //Forms
    func getFormQuestions(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.formquestions.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
    func getFormQuestionOptions(req: Request)  throws -> ResponseRepresentable {
        let workderid = try req.parameters.next(String.self)
        let preparedSQL = sql.questionoption.replacingOccurrences(of: ":1", with: workderid)
        let resp = try database.responseFrom(sqlQuery: preparedSQL)
        return try resp.makeResponse()
    }
}

