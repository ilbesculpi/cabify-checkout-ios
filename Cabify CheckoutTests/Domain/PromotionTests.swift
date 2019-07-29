//
//  PromotionTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/29/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class DateHelper {
    
    class func today() -> Date? {
        let today = Calendar.current.startOfDay(for: Date())
        return today;
    }
    
    class func yesterday() -> Date? {
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let daysToAdd = -1;
        dateComponent.day = daysToAdd;
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return futureDate;
    }
    
    class func tomorrow() -> Date? {
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let daysToAdd = 1;
        dateComponent.day = daysToAdd;
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return futureDate;
    }
    
    class func aFewDaysAgo() -> Date? {
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let daysToAdd = -5;
        dateComponent.day = daysToAdd;
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return futureDate;
    }
    
    class func aFewDaysLater() -> Date? {
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let daysToAdd = 5;
        dateComponent.day = daysToAdd;
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return futureDate;
    }
    
    class func nextMonth() -> Date? {
        
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let monthsToAdd = 1;
        dateComponent.month = monthsToAdd;
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return futureDate;
    }
    
    class func prevMonth() -> Date? {
        
        let currentDate = Date();
        
        var dateComponent = DateComponents();
        let monthsToAdd = -1;
        dateComponent.month = monthsToAdd;
        
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: currentDate);
        return pastDate;
    }
    
}

class PromotionTests: XCTestCase {
    
    var promotion: Promotion!
    
    override func setUp() {
        
    }

    override func tearDown() {
        promotion = nil;
    }

    func testPromotionNoStartAndEndDates() {
        // Promotions whithout start/end dates should ALWAYS be active
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1));
        XCTAssertTrue(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: nil);
        XCTAssertTrue(promotion.isActive);
    }
    
    func testPromotionWithEndDateAhead() {
        // Promotion with start=nil and end in the future should be active
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.aFewDaysLater());
        XCTAssertTrue(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.tomorrow());
        XCTAssertTrue(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.nextMonth());
        XCTAssertTrue(promotion.isActive);
    }
    
    func testPromotionWithEndDateInPast() {
        // Promotion with start=nil and end in the past should be inactive
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.yesterday());
        XCTAssertFalse(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.aFewDaysAgo());
        XCTAssertFalse(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: nil, end: DateHelper.prevMonth());
        XCTAssertFalse(promotion.isActive);
    }
    
    func testPromotionWithStartDateInPast() {
        // Promotion with start in the past and no end should be active
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.aFewDaysAgo(), end: nil);
        XCTAssertTrue(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.prevMonth(), end: nil);
        XCTAssertTrue(promotion.isActive);
    }
    
    func testPromotionWithStartDateAhead() {
        // Promotion with start in the future should be inactive
        let startDate: Date? = DateHelper.nextMonth();
        let endDate: Date? = nil;
        let promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: startDate, end: endDate);
        XCTAssertFalse(promotion.isActive);
    }
    
    func testPromotionStartedToday() {
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.today(), end: nil);
        XCTAssertTrue(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.today(), end: DateHelper.aFewDaysLater());
        XCTAssertTrue(promotion.isActive);
    }
    
    func testPromotionWithCurrentStartAndEndDates() {
        // Promotion with start in the future should be inactive
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.aFewDaysAgo(), end: DateHelper.aFewDaysLater());
        XCTAssertTrue(promotion.isActive);
    }
    
    func testPromotionFinished() {
        // Promotion with start/end in the past should be inactive
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.prevMonth(), end: DateHelper.aFewDaysAgo());
        XCTAssertFalse(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.aFewDaysAgo(), end: DateHelper.yesterday());
        XCTAssertFalse(promotion.isActive);
    }
    
    func testPromotionNotStarted() {
        // Promotion with start/end in the future should be inactive
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.tomorrow(), end: DateHelper.aFewDaysLater());
        XCTAssertFalse(promotion.isActive);
        promotion = Promotion(name: "2x1", code: "MUG", type: .combo(quantity: 2, free: 1), start: DateHelper.aFewDaysLater(), end: DateHelper.nextMonth());
        XCTAssertFalse(promotion.isActive);
    }

}


