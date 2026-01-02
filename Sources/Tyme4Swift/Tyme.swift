import Foundation

/// Tyme
protocol Tyme: Culture {
    /**
     推移

     - Parameters:
         - n: 推移步数。
      - Returns: 推移后的Tyme。
     */
    func next(_ n: Int) throws -> Self?
}
