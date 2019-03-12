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

class SavedBeersTestCase: XCTestCase {
    
    var savedBeersVM: SavedBeersVM!
    
    let beerRepo = BeerRepositoryMock()
    
    private let testScheduler = TestScheduler(initialClock: 0)
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        savedBeersVM = SavedBeersVM(repository: beerRepo)
    }
    
    func testViewModelBinds() {
    
        let itemDeleted = testScheduler.createColdObservable(
            [.next(5, ModelMocks.beerWrappers[0])]
        ).asDriverOnErrorJustComplete()
        
        let allDeleted = testScheduler.createColdObservable(
            [.next(10, ())]
        ).asDriverOnErrorJustComplete()
        
        let input = SavedBeersVM.Input(itemDeleted: itemDeleted, allDeleted: allDeleted)
        let output = savedBeersVM.transform(input: input)
        
        let beerSectionObserver = testScheduler.createObserver([BeerSection].self)
        let beerCountObserver = testScheduler.createObserver(Int.self)
        let deleteItemObserver = testScheduler.createObserver(UIResult.self)
        let deleteAllObserver = testScheduler.createObserver(UIResult.self)
        
        testScheduler.scheduleAt(0) {
            output.beersSection.asObservable().subscribe(beerSectionObserver).disposed(by: self.disposeBag)
            output.beerCount.asObservable().subscribe(beerCountObserver).disposed(by: self.disposeBag)
            output.deleteResult.asObservable().subscribe(deleteItemObserver).disposed(by: self.disposeBag)
            output.deleteAllResult.asObservable().subscribe(deleteAllObserver).disposed(by: self.disposeBag)
        }
    
        testScheduler.scheduleAt(15) {
            self.savedBeersVM.setExpandedCell(at: 0)
        }
        
        testScheduler.start()
        
        XCTAssertEqual(beerSectionObserver.events, [.next(0, ModelMocks.beerSections), .next(15, ModelMocks.beerSectionsWithExpandedFirstElement)])
        XCTAssertEqual(beerCountObserver.events, [.next(0, 2), .next(15, 2)])
        XCTAssertEqual(deleteItemObserver.events, [.next(5, UIResult.success("delete_success".localized))])
        XCTAssertEqual(deleteAllObserver.events, [.next(10, UIResult.success("delete_success".localized))])
        
    }

    override func tearDown() {
    
    }

}
