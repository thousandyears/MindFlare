//
// github.com/screensailor 2022
//

public struct Weak<Reference: AnyObject>: ExpressibleByNilLiteral {
    
    public private(set) weak var reference: Reference?
    
    public init(_ reference: Reference? = nil) {
        self.reference = reference
    }
    
    public init(nilLiteral: ()) {
        self.init()
    }
}

extension Weak: Equatable where Reference: Equatable {}
extension Weak: Hashable where Reference: Hashable {}
