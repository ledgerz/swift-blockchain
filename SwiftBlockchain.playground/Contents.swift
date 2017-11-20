//: SwiftBlockchain - a simple Blockchain implementation in Swift

import Foundation
import CryptoSwift

class Block {
    let index: Int
    let timeStamp: NSDate
    let previousHash: String
    let data: String
    let nonce: Int
    let hash: String

    private init(index: Int, previousHash: String, data: String) {
        self.index = index
        self.timeStamp = NSDate.init()
        self.previousHash = previousHash
        self.data = data
        (self.nonce, self.hash) = findHashWithProofOfWork(index: index, timeStamp: timeStamp, previousHash: previousHash, data: data)
    }

    convenience init(previousBlock: Block, data: String) {
        self.init(index: previousBlock.index + 1, previousHash: previousBlock.hash, data: data)
    }

    static func createGenesisBlock() -> Block {
        return Block(index: 0, previousHash: "none", data: "GenesisData")
    }
}

let difficulty = "00"

func findHashWithProofOfWork(index: Int, timeStamp: NSDate, previousHash: String, data: String) -> (nonce: Int, hash: String) {
    var nonce = 0
    var hash = ""

    while !hash.hasPrefix(difficulty) {
        nonce += 1
        let inputForHash = String(nonce) + String(describing: timeStamp) + previousHash + data
        hash = inputForHash.sha256()
    }

    return (nonce, hash)
}

let block0 = Block.createGenesisBlock()
let block1 = Block(previousBlock: block0, data: "Some data for Block 1")
let block2 = Block(previousBlock: block1, data: "Some other data for Block 2")
