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
    @IBOutlet private var initialsView: UIView!
    @IBOutlet private var userInitials: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialsView.layer.cornerRadius = 40.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func makeNew(with story: StoryModel){
        storyTitle.text = story.name
        if let initial = story.name.first {
            userInitials.text = "\(initial)"
        }
        storyDate.text = "\(story.date)"
        storyAuthor.text = "ავტორი: \(story.author)"
        storyGenre.text = "ჟანრი: \(story.genre)"
    }
    
    
}
