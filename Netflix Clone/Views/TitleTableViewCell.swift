//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Beka Buturishvili on 16.11.22.
//

import UIKit


class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    
    
    
    private let titlePosterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image  = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titlePosterImageConstraints = [
            titlePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImage.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor,constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        
        
        NSLayoutConstraint.activate(titlePosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        titlePosterImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


