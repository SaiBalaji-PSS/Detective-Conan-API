
//  Kudo Server
//  Created by Sai Balaji on 25/07/2020.





import Vapor
import Foundation




struct Movie: Codable,Content {

       public var imageurl : String?
       public var link : String?
       public var score : String?
       public var synopsis : String?
       public var title : String?
       public var url : String?
       
}

struct RootClass: Codable,Content {

        public var movies : [Movie]?
        
}

struct Ovas:Codable,Content {

        public var imageurl : String?
        public var link : String?
        public var name : String?
        public var score : String?
        public var selection2 : String?
        public var url : String?
        
}


struct OrginalVideoAnimation:Codable,Content {

        public var ova : [Ovas]?
        
}

struct Character: Codable,Content {

       public var characterimageurl : String!
       public var characterimageurlUrl : String!
       public var name : String!
       public var url : String!
       public var voiceactor : String!
       public var voiceactorUrl : String!
       public var voiceactorimageurl : String!
       public var voiceactorimageurlUrl : String!
       
}

struct VoiceActor: Codable,Content {

        public var characters : [Character]?
        
}





func routes(_ app: Application) throws {
    
    var movies = [Movie]()
    var ovas = [Ovas]()
    var characters = [Character]()
    
    let moviepath = app.directory.publicDirectory.appending("movies.json")
    let ovapath = app.directory.publicDirectory.appending("ova.json")
    let characterpath = app.directory.publicDirectory.appending("characters.json")
    
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: moviepath)) else {
        throw Abort(.notFound)
        
    }
    

    guard let ovadata = try? Data(contentsOf: URL(fileURLWithPath: ovapath))
    else { throw Abort(.notFound)}
    
    guard let characterdata = try? Data(contentsOf: URL(fileURLWithPath: characterpath)) else {
        throw Abort(.notFound)
    }
    
   
    
    
    do
    
    {
        let decoder = try JSONDecoder().decode(RootClass.self, from: data)
        let decoder2 = try JSONDecoder().decode(OrginalVideoAnimation.self, from:ovadata)
        let decoder3 = try JSONDecoder().decode(VoiceActor.self, from: characterdata)
        
        if let m = decoder.movies
        {
            movies = m
        }
        
        if let o = decoder2.ova
        {
            ovas = o
        }
        
        
        if let c = decoder3.characters
        {
            characters = c
        }
        
       
        
    
        
        
    }
    
    catch
    {
        print(error.localizedDescription)
        throw error
    }
 
    
    app.get("movies") { req in
        
        return movies
    }
    
    app.get("ova"){req in
        
        return ovas
    }
    
    app.get("characters"){req in
        
        
        return characters
    }

   
}



