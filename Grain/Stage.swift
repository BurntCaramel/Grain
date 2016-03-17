//
//  Stage.swift
//  Grain
//
//  Created by Patrick Smith on 17/03/2016.
//  Copyright © 2016 Burnt Caramel. All rights reserved.
//

import Foundation


public protocol StageProtocol {
    var nextTask: Task<Self>? { get }
}

public enum StageError<Stage: StageProtocol>: ErrorType {
    case invalidStage(Stage)
}

extension StageProtocol {
    public func mapNext<OtherStage: StageProtocol>(transform: Self throws -> OtherStage) -> Task<OtherStage> {
        guard let nextTask = self.nextTask else {
            return .unit({ throw StageError.invalidStage(self) })
        }
        
        return nextTask.map(transform)
    }
}
