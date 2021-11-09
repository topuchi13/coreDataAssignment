//
//  ViewController.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 05.11.21.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet private var storyTableView: UITableView!
    @IBOutlet private var activeUserLabel: UILabel!
    private var storyList = [StoryModel]()
    var currentUser: UserModel?
    private var storyManager = StoryManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = currentUser {
            activeUserLabel.text = "\(user.name) \(user.surname)"
            if let stories = storyManager.loadStories(except: user){
                storyList = stories
                storyTableView.reloadData()
            } else {
                print ("No stories for this user")
            }
        } else {
            print ("No current user given")
        }
        storyTableView.delegate = self
        storyTableView.dataSource = self
        storyTableView.register(UINib(nibName: "StoryCell", bundle: nil), forCellReuseIdentifier: "StoryCell")
    }
    
    @IBAction func addNew(_ sender: UIButton) {
        let sb = UIStoryboard(name: "AddNewVC", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddNewVC") as! AddNewVC
        vc.currentUser = currentUser
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNewVC
        vc.currentUser = currentUser
        vc.delegate = self
    }
    
}


extension MainVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "StoryView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "StoryView") as! StoryView
        let _ = vc.loadView()
        vc.makeNew(with: storyList[indexPath.row])
        self.present(vc, animated: true, completion: nil)
    }
}



extension MainVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryCell
        cell.makeNew(with: storyList[indexPath.row])
        return cell
    }
    
}


extension MainVC: saveNewStoryDelegate{
    func saveNewStory(this newStory: StoryModel) {
        storyManager.saveStory(this: newStory)
    }

}
