//
//  WikipediaResultTableviewCell.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 05/05/23.
//

import Foundation
import UIKit

class WikipediaResultTableviewCell: UITableViewCell {
    
    //MARK: - Variables
    
    static var reuseId = "WikipediaResultTableviewCell"
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Set Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImage)
        addSubview(titleLabel)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.anchor(left: leftAnchor,paddingLeft: 10,paddingBottom: 10,paddingRight: 10,width: 70,height: 70)
        profileImage.centerY(inView: self)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        
    }
    
    //MARK: - Custom Functions

    func setup(responseData: [Page]?,itemIndex: Int) {
        titleLabel.text = responseData?[itemIndex].extract
        loadImage(responseData: responseData?[itemIndex].thumbnail?.source, itemIndex: itemIndex)
     }

    private func loadImage(responseData: String?,itemIndex: Int) {
        guard let url = URL(string: responseData ?? "") else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: data)
            }
        }
        dataTask.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Set Views, Labels & ImageView
    
    
    var profileImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    
     let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

}
