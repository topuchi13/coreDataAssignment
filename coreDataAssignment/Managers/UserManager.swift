//
//  UserManager.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 08.11.21.
//

import UIKit
import CoreData

class UserManager {
    
    
    //Checks if given user is unique in the DB
    func isUserUnique(this user: UserModel) -> Bool{
        if let tempUser = fetchUserDataWith(this: user.email){
            if tempUser.email == user.email {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    
    
    //Fetches user data for given email
    func fetchUserDataWith(this email: String) -> UserModel?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        var fetchedUser: UserModel?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let allUsers = try managedContext.fetch(fetchRequest)
            allUsers.forEach({
                if $0.value(forKey: "email") as! String == email {
                    let name = $0.value(forKey: "name") as! String
                    let surname = $0.value(forKey: "surname") as! String
                    let password = $0.value(forKey: "password") as! String
                    fetchedUser = UserModel(name: name, surname: surname, email: email, password: password)
                }
            })
            return fetchedUser
        } catch let error as NSError {
            print (error)
        }
        fatalError("Something went realy wrong")
    }
    
    
    
    
    //Saves new user with four fields
    func saveNewUser(this newUser: UserModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(newUser.name, forKey: "name")
        user.setValue(newUser.surname, forKey: "surname")
        user.setValue(newUser.email, forKey: "email")
        user.setValue(newUser.password, forKey: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print (error)
        }
        
    }
}
