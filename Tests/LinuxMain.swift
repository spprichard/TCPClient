import XCTest

import TCPClientTests

var tests = [XCTestCaseEntry]()
tests += TCPClientTests.allTests()
XCTMain(tests)