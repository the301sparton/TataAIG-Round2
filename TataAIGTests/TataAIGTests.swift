//
//  TataAIGTests.swift
//  TataAIGTests
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import XCTest
@testable import TataAIG

class TataAIGTests: XCTestCase {
    func test_API_with_ValidRequest_ReturnsVehicelArray() {
        // Arrangements
        let expectation = self.expectation(description: "test_API_with_ValidRequest_ReturnsVehicelArray")
        let viewModel = VehicleViewModel()
        
        //Act
        viewModel.getVehicleForCoordinates(coordinates: Util.mumbaiPuneCoordinate){(result) in
           //Assert
            XCTAssertNotNil(result)  // JSON Parse Success
            XCTAssertNotNil(result.poiList) // List Parsed
            XCTAssert(result.poiList!.count > 0) //List Contains Elements
            XCTAssertNotNil(result.poiList?[0].id) //First Object has Proper Id
            XCTAssertNotNil(result.poiList?[0].coordinate) //First Object has Proper Coordinates
            XCTAssert((result.poiList?[0].heading)! <= 360) //Heading Should not be greater than 360 as its an angle
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
