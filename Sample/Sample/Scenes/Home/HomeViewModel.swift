//
//  HomeViewModel.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    //MARK: - Variables
    var breedListData = [Breed.BreadName]()
    let service: BreedProtocol!
    var breedListSuccues = Observable(false)
    
    
    //MARK: - Init Methods
    init(service: BreedProtocol = BreedService()) {
        self.service = service
    }
    
    
    //MARK: - Helper Methods
    
    
    //MARK: - Service
    func getBreedList() {
        service.getBreedData { response in
            if let data = response {
                for (key, value) in data {
                    let dogBreed = Breed.BreadName(name: key, types: value)
                    self.breedListData.append(dogBreed)
                }
            }
            self.breedListData = self.breedListData.sorted(by: { $0.name! < $1.name!})
            self.breedListSuccues.value = true
            
        } failure: { message in
            self.errorMessage.value = message ?? ""
        }
    }
}
