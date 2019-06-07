//
//  Seeds.swift
//  MoviesTests
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

struct Seeds {
}

extension Seeds {
    struct Movies {
        static let slumdogMillionaire = Movie(imdbId: "tt1010048", title: "Slumdog Millionaire", releaseDate: "2008-11-12", releaseCountry: "USA", runtime: 106)
        static let hurtLocker = Movie(imdbId: "tt1655246", title: "The Hurt Locker", releaseDate: "2009-01-29", releaseCountry: "USA", runtime: 123)
        static let kingsSpeech = Movie(imdbId: "tt1504320", title: "The King's Speech", releaseDate: "noDate", releaseCountry: "USA", runtime: 131)
        static let all = [slumdogMillionaire, hurtLocker, kingsSpeech]
    }
}
