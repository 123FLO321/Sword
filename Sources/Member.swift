//
//  Member.swift
//  Sword
//
//  Created by Alejandro Alonso
//  Copyright © 2016 Alejandro Alonso. All rights reserved.
//

import Foundation

/// Member Type
public struct Member {

  // MARK: Properties
  
  /// Parent class
  private let sword: Sword

  /// Whether or not this member is deaf
  public let deaf: Bool
  
  /// Date when user joined guild
  public let joinedAt: Date
  
  /// Whether or not this user is muted
  public let mute: Bool
  
  /// Nickname of member
  public let nick: String?
  
  /// Array of role ids this member has
  public internal(set) var roles: [String] = []
  
  /// User struct for this member
  public let user: User

  // MARK: Initializer
  
  /**
   Creates a Member struct
   
   - parameter sword: Parent class to get requester from (and otras properties)
   - parameter json: JSON representable as a dictionary
  */
  init(_ sword: Sword, _ json: [String: Any]) {
    self.sword = sword

    self.deaf = json["deaf"] as! Bool

    let joinedAt = json["joined_at"] as! String
    self.joinedAt = joinedAt.date

    self.mute = json["mute"] as! Bool
    self.nick = json["nick"] as? String

    let roles = json["roles"] as! [String]
    for role in roles {
      self.roles.append(role)
    }

    self.user = User(self.sword, json["user"] as! [String: Any])
  }

}
