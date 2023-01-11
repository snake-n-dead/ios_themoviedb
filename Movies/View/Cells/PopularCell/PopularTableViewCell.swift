//
//  PopularTableViewCell.swift
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    private let image = UIImageView()
    private let stack = UIStackView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let progress = UIProgressView()
    private let rating = PaddingLabel()
    private let arrow = UIImageView()
    
    private lazy var imageService = ImageService()
    private var imageRequest: Cancellable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white.withAlphaComponent(Alpha.transparent)
        clipsToBounds = true
        
        createArrow()
        createImage()
        createStack()
        createTitle()
        createSubtitle()
        createProgress()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
}

private extension PopularTableViewCell {
    
    func createArrow() {
        arrow.image = UIImage(named: Assets.icMore)
        arrow.contentMode = .center
        arrow.alpha = 0.4
        arrow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrow)
        addConstraints(
            [NSLayoutConstraint(item: arrow,
                                attribute: .centerY,
                                relatedBy: .equal,
                                toItem: self.contentView.safeAreaLayoutGuide,
                                attribute: .centerY,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: arrow,
                                attribute: .right,
                                relatedBy: .equal,
                                toItem: self.contentView,
                                attribute: .right,
                                multiplier: 1,
                                constant: -Offset.standart),
             NSLayoutConstraint(item: arrow,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 24)
            ])
    }
    
    func createImage() {
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .white.withAlphaComponent(Alpha.transparent)
        image.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(image)
        addConstraints(
            [NSLayoutConstraint(item: image,
                                attribute: .left,
                                relatedBy: .equal,
                                toItem: self.contentView,
                                attribute: .left,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: image,
                                attribute: .centerY,
                                relatedBy: .equal,
                                toItem: self.contentView.safeAreaLayoutGuide,
                                attribute: .centerY,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: image,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: self.contentView,
                                attribute: .height,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: image,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: image,
                                attribute: .height,
                                multiplier: 1 / Constants.pi,
                                constant: 0)
            ])
    }
    
    func createStack() {
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.contentMode = .center
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = Offset.tiny
        self.contentView.addSubview(stack)
        addConstraints(
            [NSLayoutConstraint(item: stack,
                                attribute: .left,
                                relatedBy: .equal,
                                toItem: image,
                                attribute: .right,
                                multiplier: 1,
                                constant: Offset.normal),
             NSLayoutConstraint(item: stack,
                                attribute: .right,
                                relatedBy: .equal,
                                toItem: arrow,
                                attribute: .left,
                                multiplier: 1,
                                constant: -Offset.standart),
             NSLayoutConstraint(item: stack,
                                attribute: .centerY,
                                relatedBy: .equal,
                                toItem: self.contentView,
                                attribute: .centerY,
                                multiplier: 1,
                                constant: 0)])
    }
    
    func createTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: FontSize.normal, weight: .bold)

        stack.addArrangedSubview(title)

        addConstraints(
            [NSLayoutConstraint(item: title,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 24)])
    }
    
    func createSubtitle() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.textColor = .white.withAlphaComponent(Alpha.medium)
        subtitle.font = .systemFont(ofSize: FontSize.small, weight: .light)
        subtitle.contentMode = .center
        subtitle.minimumScaleFactor = 0.5
        subtitle.adjustsFontSizeToFitWidth = true
        
        stack.addArrangedSubview(subtitle)
        addConstraints(
            [NSLayoutConstraint(item: subtitle,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 24)])
    }
    
    func createProgress() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.addArrangedSubview(progress)
        stack.addArrangedSubview(rating)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.stack.addArrangedSubview(stack)
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .orange
        
        rating.leftInset = Offset.standart
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.textColor = .white.withAlphaComponent(Alpha.medium)
        rating.textAlignment = .right
        rating.font = .systemFont(ofSize: FontSize.normal, weight: .medium)
        
        addConstraints(
            [NSLayoutConstraint(item: progress,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 4)]
        )

        addConstraints(
            [NSLayoutConstraint(item: stack,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: self.stack,
                                attribute: .width,
                                multiplier: 1,
                                constant: 0)]
        )
        addConstraints(
            [NSLayoutConstraint(item: rating,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 24)])
    }
    
    func refresh(title: String) {
        self.title.text = title
    }
    
    func refresh(genres: String) {
        subtitle.text = genres.uppercased()
    }
    
    func refresh(posterURL: String) {
        let tag = self.tag
        imageRequest = imageService.image(for: posterURL) {
            [weak self] image in
            
            guard self?.tag ?? 0 == tag else { return }
            self?.image.image = image
        }
    }
    
    func refresh(rating: Double) {
        self.rating.text = "\(rating)"
    }
    
    func refresh(ratingValue: Float) {
        progress.progress = ratingValue
    }
}

//MARK: - PopularCellViewInput methods

extension PopularTableViewCell: PopularCellViewInput {
    
    func refresh(state: PopularCellState) {
        switch state {
        case .title(let string):
            refresh(title: string)
        case .genres(let string):
            refresh(genres: string)
        case .posterURL(let string):
            refresh(posterURL: string)
        case .rating(let double):
            refresh(rating: double)
        case .ratingValue(let float):
            refresh(ratingValue: float)
        }
    }
}
