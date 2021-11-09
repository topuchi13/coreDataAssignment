//
//  addNewVC.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 05.11.21.
//

import UIKit

class AddNewVC: UIViewController {
    
    
    @IBOutlet private var storyTitle: UITextField!
    @IBOutlet private var storyDate: UILabel!
    @IBOutlet private var storyAuthor: UILabel!
    @IBOutlet private var storyGenre: UITextField!
    @IBOutlet private var storyText: UITextView!
    @IBOutlet var allFields: [UITextField]!
    
    var currentUser: UserModel?
    var delegate: saveNewStoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allFields.forEach({
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.lightGray.cgColor
        })
        storyText.layer.borderColor = UIColor.lightGray.cgColor
        storyText.layer.borderWidth = 1.0
        storyText.layer.cornerRadius = Constants.cornerRadius
        if let thisUser = currentUser {
            storyAuthor.text = "\(thisUser.name) \(thisUser.surname)"
            storyDate.text = getCurrentDate()
        }
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        let title = storyTitle.text
        let date = storyDate.text
        let author = storyAuthor.text
        let genre = storyGenre.text
        let text = storyText.text
        
        let newStory = StoryModel(name: title!, date: date!, author: author!, genre: genre!, body: text!, userEmail: currentUser!.email)
        delegate?.saveNewStory(this: newStory)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    

}

protocol saveNewStoryDelegate{
    func saveNewStory(this newStory: StoryModel)
}
