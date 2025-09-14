//
//  UserDirectoryTests.swift
//  UserDirectoryTests
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import XCTest
import Combine

@testable import UserDirectory

final class UserDirectoryTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let kcm = KeychainManager.shared

    override
    func setUp() {
        super.setUp()
        kcm.deleteToken()
    }
    
    override
    func tearDown() {
        kcm.deleteToken()       // delete after test
        super.tearDown()
        
    }

    // MARK: - Test 1:- Login API call with mock response (for success)
    func testLoginSuccessPublishesTrue() {
        let mockService = MockAuthService()
        mockService.tokenToReturn = "token.faysal.123"
        
        let vm = AuthenticationViewModel(service: mockService)
        let expec = expectation(description: "Login success")
        
        let cancellable = vm.$loginSuccess
            .dropFirst()
            .sink { success in
                if success {
                    XCTAssertTrue(success)
                    XCTAssertEqual(UserDefaults.standard.isLogin, true)
                    expec.fulfill()
                }
            }
        
        vm.login(email: "faysalf@gmail.com", password: "fromDhaka")
        wait(for: [expec], timeout: 3)
        cancellable.cancel()
        
    }
    
    // Test 1:- Login API call with mock response (for Failure)
    func testLoginFailurePublishesError() {
        let mockService = MockAuthService()
        mockService.shouldFail = true
        mockService.errorToReturn = URLError(.notConnectedToInternet)
        
        let vm = AuthenticationViewModel(service: mockService)
        let expec = expectation(description: "Login failure")
        
        let cancellable = vm.$errorMessage
            .dropFirst()
            .sink { msg in
                if msg != nil {
                    XCTAssertNotNil(msg)
                    expec.fulfill()
                }
            }
        
        vm.login(email: "faysalf@gmail.com", password: "fromDhaka")
        wait(for: [expec], timeout: 3)
        cancellable.cancel()
        
    }
    
    // MARK: - Test 2:- Users list API parsing (for success)
    func testFetchUsersFromReqRes() {
        let expectation = expectation(description: "Fetch real users from ReqRes")
        let vm = DashboardViewModel(service: DashboardService())

        vm.$users
            .dropFirst()
            .sink { users in
                debugPrint("######## Test user list api first user name:- \(users.first?.fullName ?? "N/A"), and total \(users.count)")
                XCTAssertFalse(users.isEmpty, "User array should not be empty")
                XCTAssertNotNil(users.first?.email)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        vm.getUsers()

        wait(for: [expectation], timeout: 5)
    }

    // Test 2:- Users list API parsing (for failure)
    func testFetchUsersFailureSetsError() {
        let fakeResponse = UserListModel(page: 1, perPage: 1, total: 1, totalPages: 12, data: [])
        let mockService = MockDashboardService(sampleResponse: fakeResponse)
        mockService.shouldFail = true
        mockService.errorToReturn = URLError(.notConnectedToInternet)
        
        let vm = DashboardViewModel(service: mockService)
        let expectation = expectation(description: "Setting error for users list")

        vm.$errorMessage
            .dropFirst()
            .sink { msg in
                if msg != nil {
                    XCTAssertNotNil(msg)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.getUsers()
        
        wait(for: [expectation], timeout: 2)
        
    }

    // MARK: - Test3:- Token storage & retrieval.
    func testTokenStorageAndRetrieval() {
        let testToken = "ahmed.123"
        
        let saveToken = kcm.saveToken(testToken)
        XCTAssertTrue(saveToken, "Token saved successful")
        
        let retrieve = kcm.getToken()
        XCTAssertEqual(testToken, retrieve, "Both token should be same")
        
    }

    // Test3:- Token deletion
    func testTokenDeletion() {
        let testToken = "ahmed.123"
        _ = kcm.saveToken(testToken)
        let deleteSuccess = kcm.deleteToken()
        XCTAssertTrue(deleteSuccess)
        XCTAssertNil(kcm.getToken())
    }
    
}

// MARK: - Mock Auth Service class
final class MockAuthService: AuthenticationServiceProtocol {
    var tokenToReturn = "fake.token.123"
    var shouldFail = false
    var errorToReturn: Error = URLError(.badServerResponse)
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponseModel, Error> {
        if shouldFail {
            return Fail(error: errorToReturn).eraseToAnyPublisher()
        }
        let response = LoginResponseModel(token: tokenToReturn)
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Mock Dashboard Service Class
final class MockDashboardService: DashboardServiceProtocol {
    var sampleResponse: UserListModel
    var shouldFail = false
    var errorToReturn: Error = URLError(.badServerResponse)

    init(sampleResponse: UserListModel) {
        self.sampleResponse = sampleResponse
    }

    func getUserList(currentPage: Int, pageSize: Int) -> AnyPublisher<UserListModel, Error> {
        if shouldFail {
            return Fail(error: errorToReturn).eraseToAnyPublisher()
        }
        return Just(sampleResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
