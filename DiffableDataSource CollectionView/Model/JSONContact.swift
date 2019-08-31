//
//  JSONContact.swift
//  DiffableDataSource CollectionView
//
//  Created by Yoel Lev on 31/08/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import Foundation

struct JSONContact: Decodable,Hashable {
    let name: String
    let imageUrl: String
}
