//
//  DetailDetailViewController.swift
//

import UIKit

class DetailViewController: BaseModuleViewController {

    var output: DetailViewOutput?

    //MARK: Props
    
    @IBOutlet private weak var posterImage: UIImageView?
    @IBOutlet private weak var overviewLabel: PaddingLabel?
    @IBOutlet private weak var castLabel: PaddingLabel?
    
    private let ratingButton = UIBarButtonItem()
    
    private lazy var imageService = ImageService()
    private var imageRequest: Cancellable?
    
    //MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewOnReady()
    }

    private func setupUI() {
        navigationItem.rightBarButtonItem = ratingButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewOnAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageRequest?.cancel()
    }
}

private extension DetailViewController {
    
    func update(posterURL: String) {
        imageRequest = imageService.image(for: posterURL) {
            [weak self]
            image in
            
            self?.posterImage?.image = image
        }
    }
    
    func update(overview: String) {
        overviewLabel?.text = overview
    }
    
    func update(rating: Double) {
        ratingButton.title = "\(rating) \(Constants.cup)"
    }
    
    func update(cast: String) {
        castLabel?.text = cast
    }
}

//MARK: -

extension DetailViewController: DetailViewInput {
    
    func update(state: DetailState) {
        switch state {
        case .posterURL(let value):
            update(posterURL: value)
        case .overview(let value):
            update(overview: value)
        case .rating(let value):
            update(rating: value)
        case .cast(let value):
            update(cast: value)
        }
    }
}
