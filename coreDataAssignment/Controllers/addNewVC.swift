//
//  addNewVC.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 05.11.21.
//

import UIKit

class addNewVC: UIViewController {
    
    
    @IBOutlet private var storyTitle: UITextField!
    @IBOutlet private var storyDate: UITextField!
    @IBOutlet private var storyAuthor: UITextField!
    @IBOutlet private var storyGenre: UITextField!
    @IBOutlet var storyText: UITextView!
    
    var delegate: saveNewStoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        let title = storyTitle.text
        let date = storyDate.text
        let author = storyAuthor.text
        let genre = storyGenre.text
        let text = storyText.text
        
        let newStory = StoryObject(name: title!, date: date!, author: author!, genre: genre!, body: text!)
        delegate?.saveNewStory(this: newStory)
        self.navigationController?.popViewController(animated: true)
    }
    

}

protocol saveNewStoryDelegate{
    func saveNewStory(this newStory: StoryObject)
}
