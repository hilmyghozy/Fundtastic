//
//  CategoryInterface.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 14/12/21.
//

import Foundation

protocol CategoryInterface {
    func doGetAllItem(category: String)
}

protocol CategoryDelegate: AnyObject {
    func didSuccessGetItems()
    func didFailedGetItems(errorMessage: String)
}

class CategoryPresenter: CategoryInterface {
    
    weak var delegate: CategoryDelegate?
    private let networkManager: NetworkManager
    
    var responseItems: apiResponse<CategoryModel>? = nil
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func doGetAllItem(category: String) {
        networkManager.requestItems(parameter: category, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.responseItems = response
                strongSelf.delegate?.didSuccessGetItems()
            case .failure(let error):
                self?.delegate?.didFailedGetItems(errorMessage: error.localizedDescription)
            }
        })
    }
    
}
