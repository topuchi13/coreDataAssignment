//
//  ViewController.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 05.11.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet private var newsTableView: UITableView!
    private var newsList = [StoryObject]()
    private var fetchedStories = [NSManagedObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStories()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "StoryCell", bundle: nil), forCellReuseIdentifier: "StoryCell")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! addNewVC
        vc.delegate = self
    }
    
    
    func loadStories() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Story")
        
        do {
            fetchedStories = try managedContext.fetch(fetchRequest)
            fetchedStories.forEach({
                newsList.append(StoryObject(name: "\($0.value(forKey: "header")!)", date: "\($0.value(forKey: "date")!)", author: "\($0.value(forKey: "author")!)", genre: "\($0.value(forKey: "genre")!)", body: "\($0.value(forKey: "body")!)"))
            })
        } catch let error as NSError {
            print (error)
        }
        
    }
    
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "StoryView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "StoryView") as! StoryView
        let _ = vc.loadView()
        vc.makeNew(with: newsList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryCell
        cell.makeNew(with: newsList[indexPath.row])
        return cell
    }
    
}


extension ViewController: saveNewStoryDelegate{
   
    func saveNewStory(this newStory: StoryObject){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Story", in: managedContext)!
        
        let story = NSManagedObject(entity: entity, insertInto: managedContext)
        
        story.setValue(newStory.body, forKey: "body")
        story.setValue(newStory.genre, forKey: "genre")
        story.setValue(newStory.author, forKey: "author")
        story.setValue(newStory.date, forKey: "date")
        story.setValue(newStory.name, forKey: "header")
        
        do {
            try managedContext.save()
            newsList.append(newStory)
            newsTableView.reloadData()
        } catch let error as NSError {
            print (error)
        }
        
    }
}
