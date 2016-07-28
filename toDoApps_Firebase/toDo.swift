//
//  toDo.swift
//  
//
//  Created by Mohammad Kukuh on 7/27/16.
//
//

import Foundation
import FirebaseDatabase

struct toDo {
    let key : String!
    let title : String!
    let description : String!
    let addedIn : String!
    let itemRef : FIRDatabaseReference?
    
    init(title:String,description:String,addedIn:String,key:String=""){
        self.key = key
        self.title = title
        self.description = description
        self.addedIn = addedIn
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let toDoTitle = snapshot.value!["title"] as?  String{
            title = toDoTitle
        }else{
            title = ""
        }
        if let toDoDes = snapshot.value!["description"] as? String{
            description = toDoDes
        }else{
            description = ""
        }
        if let toDoDate = snapshot.value!["addedIn"] as? String{
            addedIn = toDoDate
        }else{
            addedIn = nil
        }
    }

    func toAnyObject() -> AnyObject{
        return["title":title,"description":description,"addedIn":addedIn]
    }
}