// https://github.com/Quick/Quick

import Quick
import Nimble

@testable import SnSRestKit

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Test SnSRestKit initialization") {
                        
            SnSRestKit.initializeRestKit() { (config) in
                config.loggingEnable = true
                config.cacheEnable = false
                config.baseApiUrl = ""
            }            
            
            it("can do maths") {
                expect(1) == 2
            }

            it("can read") {
                expect("number") == "string"
            }

            it("will eventually fail") {
                expect("time").toEventually( equal("done") )
            }
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    DispatchQueue.main.async {
                        time = "done"
                    }

                    waitUntil { done in
                        Thread.sleep(forTimeInterval: 0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
