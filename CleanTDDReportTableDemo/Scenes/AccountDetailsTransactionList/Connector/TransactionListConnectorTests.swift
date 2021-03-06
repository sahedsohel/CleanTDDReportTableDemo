//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListConnectorTests: XCTestCase {
    
    private var sut: TransactionListConnector!
    private var controller: TransactionListViewController!
    private var useCase: TransactionListUseCase!
    private var presenter: TransactionListPresenter!
    
    override func setUp() {
        super.setUp()
        
        controller = TransactionListViewController()
        useCase = TransactionListUseCase(entityGateway: FakeNilEntityGateway())
        presenter = TransactionListPresenter(useCase: useCase)
        
        sut = TransactionListConnector(viewController: controller, useCase: useCase, presenter: presenter)
        sut.configure()
    }
    
    func test_Init_SetsViewController() {
        XCTAssertTrue(sut.viewController === controller)
    }
    
    func test_Init_SetsPresenter() {
        XCTAssertTrue(sut.presenter === presenter)
    }
    
    func test_Init_SetsUseCase() {
        XCTAssertTrue(sut.useCase === useCase)
    }
    
    func test_Configure_SetsControllersPresenter() {
        XCTAssertTrue(controller.presenter === presenter)
    }
    
    func test_Configure_SetsUseCasesOutput() {
        XCTAssertTrue(useCase.output === presenter)
    }
    
    func test_Configure_SetsPresentersOutput() {
        XCTAssertTrue(presenter.output === controller)
    }
}
