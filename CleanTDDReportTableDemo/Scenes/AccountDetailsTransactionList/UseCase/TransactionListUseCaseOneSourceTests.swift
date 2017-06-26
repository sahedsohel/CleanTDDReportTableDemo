//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListUseCaseOneSourceTests: XCTestCase {
    private var sut: TransactionListUseCase!
    private var stubPresenter: StubTransactionListPresenter!
    private var entityGateway = EntityGatewayFactory.makeEntityGateway()

    private var oneSourceTransformer: StubTransactionListUseCaseBeginOneSourceTransformer!

    override func setUp() {
        super.setUp()

        oneSourceTransformer = StubTransactionListUseCaseBeginOneSourceTransformer(allTransactions: [])

        stubPresenter = StubTransactionListPresenter()
        sut = TransactionListUseCase(entityGateway: entityGateway)
        sut.output = stubPresenter
    }

    func test_beginOneSource_CallsTransformer() {
        
        sut.beginOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.didCall)
    }
    
    func test_beginOneSource_CallsTransformerWithPresenter() {
        
        sut.beginOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.presenter === stubPresenter)
    }

    // MARK: Stubs

    class StubTransactionListUseCaseBeginOneSourceTransformer: TransactionListUseCaseBeginOneSourceTransformer {
        
        var didCall = false
        var presenter: TransactionListUseCaseOutput!
        
        override func transform( output presenter: TransactionListUseCaseOutput ) {
            
            didCall = true
            self.presenter = presenter
        }
    }
    
    class StubTransactionListPresenter: TransactionListUseCaseOutput {

        func presentInit() {}
        func presentHeader(group: TransactionGroup) {}
        func presentSubheader(date: Date) {}
        func presentDetail(description: String, amount: Double) {}
        func presentSubfooter() {}
        func presentFooter(total: Double) {}
        func presentGrandFooter(grandTotal: Double) {}
        func presentNotFoundMessage(group: TransactionGroup) {}
        func presentNoTransactionsMessage(group: TransactionGroup) {}
        func presentNotFoundMessage() {}
        func presentReport() {}
    }
}