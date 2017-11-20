//: SwiftBlockchain - a simple Blockchain implementation in Swift

import Foundation
import CryptoSwift

class Block {
    let index: Int
    let timeStamp: NSDate
    let hash: String
    let previousHash: String
    let data: String

    private init(index: Int, previousHash: String, data: String) {
        self.index = index
        self.timeStamp = NSDate.init()
        self.hash = data.sha256()
        self.previousHash = previousHash
        self.data = data
    }

    convenience init(previousBlock: Block, data: String) {
        self.init(index: previousBlock.index + 1, previousHash: previousBlock.hash, data: data)
    }

    static func createGenesisBlock() -> Block {
        return Block(index: 0, previousHash: "none", data: "GenesisData")
    }
}

let block0 = Block.createGenesisBlock()
let block1 = Block(previousBlock: block0, data: "Some data for Block 1")
let block2 = Block(previousBlock: block1, data: "Some other data for Block 2")
