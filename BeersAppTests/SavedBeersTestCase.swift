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
    
    private var savedBeersVM: SavedBeersVM!
    private let beerRepo = BeerRepositoryMock()
    
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
        
        //loaded at first subscribe (0), at 15 new list with expanded first element triggered by setExpandedCell(at: 0)
        XCTAssertEqual(beerSectionObserver.events, [.next(0, ModelMocks.beerSections), .next(15, ModelMocks.beerSectionsWithExpandedFirstElement)])
        //mapping from beerSections, returning 2 elements twice, at 0 and 15 (because of expanding)
        XCTAssertEqual(beerCountObserver.events, [.next(0, 2), .next(15, 2)])
        //delete item triggered at 5 called deletion logic successfully
        XCTAssertEqual(deleteItemObserver.events, [.next(5, UIResult.success("delete_success".localized))])
        //delete all items triggered at 10 called deletion logic successfully
        XCTAssertEqual(deleteAllObserver.events, [.next(10, UIResult.success("delete_success".localized))])
        
    }
    
    func testViewModelBindsWithFailuresFromRepo() {
        beerRepo.shouldFail = true
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
        
        //Completions and stream terminations happening (I assume) because drivers are transformed to observables to test, otherwise in real application using Drivers that don't terminate
        
        //return empty array on error and complete
        XCTAssertEqual(beerSectionObserver.events, [.next(0, []), .completed(0)])
        //no results, so 0 and complete
        XCTAssertEqual(beerCountObserver.events, [.next(0, 0), .completed(0)])
        //deletion errror and completion
        XCTAssertEqual(deleteItemObserver.events, [.next(5, UIResult.error("delete_error".localized)), .completed(5)])
        //deletion error and completion
        XCTAssertEqual(deleteAllObserver.events, [.next(10, UIResult.error("delete_error".localized)), .completed(10)])
    }

    override func tearDown() {
        beerRepo.shouldFail = false
    }

}
