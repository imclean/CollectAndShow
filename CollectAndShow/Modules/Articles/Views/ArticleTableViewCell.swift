//
//  ArticleTableViewCell.swift
//  CollectAndShow
//
//  Created by Iain McLean on 06/11/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var descriptionLabel:UILabel!
    
    var article:Article?
}
