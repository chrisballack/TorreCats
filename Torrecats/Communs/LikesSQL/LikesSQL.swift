//
//  LikesSQL.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import Foundation
import SQLite
import UIKit

class LikesSQL{
    
    var database: Connection!
    let LikesTable = Table("LikesTable")
    let IsLike = Expression<Bool>("IsLike")
    let Name = Expression<String>("Name")
    let Date = Expression<Date>("Date")
    
    init(){
        
        do {
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Likes").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            database = db
            
        } catch {
            
            print(error)
            
        }
        
    }
    
    func createTable() {
        
        let createTable = LikesTable.create {
            
            (table) in
            table.column(IsLike)
            table.column(Name)
            table.column(Date)
            
        }
        
        do {
            
            try database.run(createTable)
            print("Created Table")
            
        } catch {
            
            print(error)
            
        }
        
    }
    
    func DeleteLike(NameFunc:String){
        
        let Like = LikesTable.filter(Name == NameFunc)
        let deleteLike = Like.delete()
        
        do{
            
            try database.run(deleteLike)
            print("Delete Like")
            
        }catch{
            
            print(error)
            
        }
        
    }
    
    func UpdateLike(NameFunc:String,IsLikeFunc:Bool,DateFunc:Date,completion : @escaping (Bool) -> ()){
        
        let LikeFilter = LikesTable.filter(Name == NameFunc)
        let updateLike = LikeFilter.update(IsLike <- IsLikeFunc,Date <- DateFunc)
        
        do {
            
            try database.run(updateLike)
            print("Update like")
            print(listLikes())
            completion(true)
            
        } catch {
            
            print(error)
            completion(false)
            
        }
        
    }

    func insertLike(IsLikeFunc:Bool,NameFunc:String,DateFunc:Date) {
        
        IsExist(NameFunc: NameFunc) { [self] Result in
            
            if Result == true{
                
                UpdateLike(NameFunc: NameFunc, IsLikeFunc: IsLikeFunc, DateFunc: DateFunc) { _ in }
                
            }else{
                
                let insertLike = LikesTable.insert(IsLike <- IsLikeFunc,Name <- NameFunc,Date <- DateFunc)
                
                do {
                    
                    try database.run(insertLike)
                    print("Insert like")
                    
                } catch {
                    
                    print(error)
                    
                }
                
            }
            
        }
        
        
        
    }
    
    private func IsExist(NameFunc:String,completion : @escaping (Bool) -> ()){
        
        let LikeFilter = LikesTable.filter(Name == NameFunc)
        
        do {
            
            let Likes = try database.prepare(LikeFilter)
            
            var Count = 0
            for _ in Likes{
                
                Count += 1
                
            }
            
            if Count == 0 {
                
                completion(false)
                
            }else{
                
                completion(true)
                
            }
            
        } catch {
            
            print(error)
            completion(false)
            
        }
        
        
    }

    func listLikes() -> [(IsLike:Bool,Name:String,DateFunc:Date)] {
        
        var LocalArray:[(IsLike:Bool,Name:String,DateFunc:Date)] = []
        
        do {
            
            let Likes = try database.prepare(LikesTable)
            
            for Like in Likes {
                
                LocalArray.append((IsLike: Like[IsLike], Name: Like[Name], DateFunc: Like[Date]))
                
            }
            return LocalArray
            
        } catch {
            
            print(error)
            return []
            
        }
    
    
}
    
    func IsReadyLiked(NameFunc:String) -> Bool?{
        
        let user = LikesTable.filter(Name == NameFunc)
        
        do {
            
            let users = try database.prepare(user)
            
            var Value:Bool?
            
            for user in users {
                
                if user[Name] != ""{
                    
                    Value = user[IsLike]
                    
                }
                
            }
            
            return Value
            
        } catch {
            
            print(error)
            return nil
            
        }
        
    }
    
}
