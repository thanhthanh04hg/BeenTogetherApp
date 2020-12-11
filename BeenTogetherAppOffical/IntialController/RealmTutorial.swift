//
//  RealmTutorial.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/13/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import RealmSwift


class RealmService {
    static var shared = RealmService()
    
    func load<T: Object>(listOf: T.Type, filter: String? = nil) -> [T] {
        do {
            var objects = try Realm().objects(T.self)
            if let filter = filter {
                objects = objects.filter(filter)
            }
            var list = [T]()
            for obj in objects {
                list.append(obj)
            }
            return list
        } catch {}
        return []
    }
    func add(_ object : Object, filter : String? = nil ) {
        do{
            let realm = try! Realm()
            try! realm.write {
                realm.add(object)
            }
        }catch{
            print ("Can't add")
        }
    }
    func get<T:Object>(_: T.Type,filter:String?=nil) -> T {
        do{
            let realm = try Realm()
            var result = realm.objects(T.self).filter(filter!).last
            return result!
        }catch{
            print("unsuccessful")
        }
        return T()
    }
    
    
}


