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

    // MARK: - Test 1:- Login API call with mock response.
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
    
    
    // MARK: - Test 2:- Users list API parsing.
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
    
    
    // MARK: - Test3:- Token storage & retrieval.
    func testTokenStorageAndRetrieval() {
        let testToken = "ahmed.123"
        
        let saveToken = kcm.saveToken(testToken)
        XCTAssertTrue(saveToken, "Token saved successful")
        
        let retrieve = kcm.getToken()
        XCTAssertEqual(testToken, retrieve, "Both token should be same")
        
    }

}

// MARK: - Mock Auth Service class
final class MockAuthService: AuthenticationServiceProtocol {
    var tokenToReturn = "fake.token.123"
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponseModel, Error> {
        let response = LoginResponseModel(token: tokenToReturn)
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

    }
    
}
