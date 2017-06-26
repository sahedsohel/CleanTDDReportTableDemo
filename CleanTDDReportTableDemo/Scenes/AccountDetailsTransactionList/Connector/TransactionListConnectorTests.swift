//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListConnectorTests: XCTestCase {
    
    private var sut: TransactionListConnector!
    private var adapter: TransactionListAdapter!
    private var controller: TransactionListViewController!
    private var useCase: TransactionListUseCase!
    private var presenter: TransactionListPresenter!
    
    override func setUp() {
        super.setUp()
        
        controller = TransactionListViewController()
        adapter = TransactionListAdapter()
        useCase = TransactionListUseCase(entityGateway: EntityGatewayFactory.makeEntityGateway())
        presenter = TransactionListPresenter(useCase: useCase)
        
        sut = TransactionListConnector(viewController: controller, adapter: adapter, useCase: useCase, presenter: presenter)
        sut.configure()
    }
    
    func test_Configure_SetsControllersPresenter() {
        XCTAssertTrue(controller.presenter === presenter)
    }
    
    func test_Configure_SetsAdaptersPresenter() {
        XCTAssertTrue(adapter.presenter === presenter)
    }
    
    func test_Configure_SetsUseCasesOutput() {
        XCTAssertTrue(useCase.output === presenter)
    }
    
    func test_Configure_SetsPresentersOutput() {
        XCTAssertTrue(presenter.output === controller)
    }
    
}
