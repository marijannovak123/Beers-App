//
//  BeerRepositoryTestCase.swift
//  BeersAppTests
//
//  Created by Marijan on 12/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import XCTest
@testable import BeersApp
import RxSwift
import RxBlocking

class BeerRepositoryTestCase: XCTestCase {

    private var beerRepository: BeerRepositoryImpl!
    
    private let beerService = BeerServiceMock()
    private let beerStorage = BeerStorageMock()
    
    override func setUp() {
        beerRepository = BeerRepositoryImpl(service: beerService, storage: beerStorage)
    }

    func testFetchBeers() {
        let fetchedBeers = try! beerRepository.fetchBeers(query: "testString").toBlocking().first()!
        XCTAssertEqual(fetchedBeers, ModelMocks.beers)
    }
    
    func testSaveBeer() {
        let savedEvent = try! beerRepository.saveBeer(ModelMocks.beers.first!).toBlocking().toArray()
        XCTAssert(savedEvent.count > 0)
    }
    
    func testLoadPersistedBeers() {
       let loadedBeers = try! beerRepository.loadPersistedBeers().toBlocking().first()!
        XCTAssertEqual(loadedBeers, ModelMocks.beers)
    }
    
    func testDeleteBeer() {
        let isDeleted = try! beerRepository.deleteBeer(ModelMocks.beers[0]).toBlocking().toArray()
        XCTAssert(isDeleted.count > 0)
    }
    
    func testDeleteAllBeers() {
        let isDeleted = try! beerRepository.deleteAllBeers().toBlocking().toArray()
        XCTAssert(isDeleted.count > 0)
    }
    
    override func tearDown() {
       
    }

}
