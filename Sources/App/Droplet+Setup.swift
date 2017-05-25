@_exported import Vapor

extension Droplet {
    public func setup() throws {
        try collection(Routes.self)
        //add old main stuff here
        
        let jm = JobManagerGetController(drop: self)
        jm.addRoutesToDrop()
       
        let jmp = JobManagerPostController(drop: self)
        jmp.addRoutesToDrop()
        
        let ha = HiveAdminPostController(drop: self)
        ha.addRoutesToDrop()
        
    }
}
