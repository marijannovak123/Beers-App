//
//  BeerSearchTestCase.swift
//  BeersAppTests
//
//  Created by Marijan on 11/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
import RxCocoa
import RxSwift
import RxDataSources
@testable import BeersApp

class BeerSearchTestCase: XCTestCase {

    var beerSearchVM: BeerSearchVM!
    
    let beerRepo = BeerRepositoryMock()
    
    private let testScheduler = TestScheduler(initialClock: 0)
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        beerSearchVM = BeerSearchVM(repository: beerRepo)
    }

    func testFetchBeers() {
        let searchText: Driver<String?> = testScheduler.createHotObservable([next(100, "beer")]).asDriverOnErrorJustComplete()
        let selection: Driver<IndexPath> = testScheduler.createHotObservable([]).asDriverOnErrorJustComplete()
        let saveTrigger: Driver<SwipeEvent> = testScheduler.createHotObservable([]).asDriverOnErrorJustComplete()
        
        let input = BeerSearchVM.Input(searchText: searchText, selectionTrigger: selection, saveTrigger: saveTrigger)
        let output = beerSearchVM.transform(input: input)
        
        let observer = testScheduler.createObserver([SectionModel<String, Beer>].self)
        
        output.beersSection.drive(observer).disposed(by: disposeBag)
        
        testScheduler.start()
        
        let expectedEvents: [Recorded<Event<[SectionModel<String, Beer>]>>] = [
            next(100, [SectionModel(model: "Beers", items: ModelMocks.beers)])
        ]
        

    }
    
    override func tearDown() {
        
    }

}
