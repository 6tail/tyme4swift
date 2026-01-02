/// 抽象Tyme
public class AbstractTyme: AbstractCulture, Tyme {
    func next(_ n: Int) throws -> Self? {
        fatalError("not implement")
    }
}
