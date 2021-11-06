//
//  StoryCell.swift
//  coreDataAssignment
//
//  Created by Nika Topuria on 05.11.21.
//

import UIKit

class StoryCell: UITableViewCell {
    
    @IBOutlet private var storyTitle: UILabel!
    @IBOutlet private var storyDate: UILabel!
    @IBOutlet private var storyAuthor: UILabel!
    @IBOutlet private var storyGenre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func makeNew(with story: StoryObject){
        storyTitle.text = story.name
        storyDate.text = "Date: \(story.date)"
        storyAuthor.text = "Author: \(story.author)"
        storyGenre.text = "Genre: \(story.genre)"
    }
    
    
}
