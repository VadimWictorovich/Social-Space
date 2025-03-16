//
//  CustomCell.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 16.03.25.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    private let imgProfile = UIImageView()
    private let titlePost = UILabel()
    private let bodyPost = UILabel()
    private let like = UIImageView()
    
    // MARK: - LIFE CIRLE

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS
    
    private func addViews() {
        addSubview(imgProfile)
        addSubview(titlePost)
        addSubview(bodyPost)
        addSubview(like)
    }
    
    private func addSettings() {
        selectionStyle = .none
        settingsForImgProfile()
        settingsForTitlePost()
        settingsForBodyPost()
        settingsForLike()
    }
    
    private func settingsForImgProfile() {
        imgProfile.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imgProfile.contentMode = .scaleAspectFit
        imgProfile.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imgProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgProfile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            imgProfile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imgProfile.widthAnchor.constraint(equalToConstant: 50),
            imgProfile.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func settingsForTitlePost() {
        titlePost.font = .systemFont(ofSize: 14, weight: .medium)
        titlePost.textColor = .gray
        titlePost.numberOfLines = 0
        titlePost.textAlignment = .left
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlePost.leadingAnchor.constraint(equalTo: imgProfile.leadingAnchor, constant: 80),
            titlePost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titlePost.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30)
        ])
    }
    
    private func settingsForBodyPost() {
        bodyPost.font = .systemFont(ofSize: 14, weight: .medium)
        bodyPost.textAlignment = .justified
        bodyPost.numberOfLines = 0
        bodyPost.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyPost.topAnchor.constraint(equalTo: imgProfile.bottomAnchor, constant: 20),
            bodyPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            bodyPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func settingsForLike() {
        like.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        like.contentMode = .scaleAspectFit
        like.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            like.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            like.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func statusLike(isLiked: Bool) -> (UIColor, UIImage) {
        return isLiked ? ( .red, UIImage(systemName: "heart.fill")!) : ( .gray, UIImage(systemName: "heart")!)
    }
    
    func config(prfileImage: UIImage?, title: String?, body: String?, liked: Bool = false) {
        imgProfile.image = prfileImage
        titlePost.text = title
        bodyPost.text = body
        like.tintColor = statusLike(isLiked: liked).0
        like.image = statusLike(isLiked: liked).1
    }
}
