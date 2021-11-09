//
//  StoryView.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 06.11.21.
//

import UIKit

class StoryView: UIViewController {

    
    @IBOutlet var storyTitle: UILabel!
    @IBOutlet var storyDate: UILabel!
    @IBOutlet var storyAuthor: UILabel!
    @IBOutlet var storyGenre: UILabel!
    @IBOutlet var storyBody: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func makeNew(with story: StoryModel){
        storyTitle.text = story.name
        storyDate.text = "\(story.date)"
        storyAuthor.text = "ავტორი: \(story.author)"
        storyGenre.text = "ჟანრი: \(story.genre)"
        storyBody.text = story.body
        storyBody.sizeToFit()
    }

}
