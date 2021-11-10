//
//  StoryManager.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 09.11.21.
//

import UIKit
import CoreData


class StoryManager{
    
    func loadStories(except user: UserModel) -> [StoryModel]? {
        var storyList = [StoryModel]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print ("Couldn't access UIApplication shared delegate")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Story")
        
        do {
            let fetchedStories = try managedContext.fetch(fetchRequest)
            if !fetchedStories.isEmpty {
                fetchedStories.forEach({
                    if "\($0.value(forKey: "email")!)" != user.email {
                        storyList.append(StoryModel(name: "\($0.value(forKey: "header")!)", date: "\($0.value(forKey: "date")!)", author: "\($0.value(forKey: "author")!)", genre: "\($0.value(forKey: "genre")!)", body: "\($0.value(forKey: "body")!)", userEmail: "\($0.value(forKey: "email")!)"))
                    }
                })
            } else {
                print ("No stories to show")
                return nil
            }
            return storyList
        } catch let error as NSError {
            print (error)
            return nil
        }
        
    }
    
    
    func saveStory(this newStory: StoryModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Story", in: managedContext)!
        let story = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //Sets values for each story entity key
        story.setValue(newStory.body, forKey: "body")
        story.setValue(newStory.genre, forKey: "genre")
        story.setValue(newStory.author, forKey: "author")
        story.setValue(newStory.date, forKey: "date")
        story.setValue(newStory.name, forKey: "header")
        story.setValue(newStory.userEmail, forKey: "email")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print (error)
        }
    }
}
