import Foundation
import Dispatch
import WebSockets

class Heartbeat {

  let session: WebSocket

  let interval: Int
  var sequence: [Int] = []

  let queue = DispatchQueue(label: "gg.azoy.sword.heartbeat", qos: .userInitiated)

  init(_ ws: WebSocket, interval: Int) {
    self.session = ws
    self.interval = interval
  }

  func send() {
    let deadline = DispatchTime.now() + DispatchTimeInterval.milliseconds(self.interval)

    queue.asyncAfter(deadline: deadline) {
      let heartbeat = Payload(op: .heartbeat, data: self.sequence.first ?? NSNull()).encode()
      if self.sequence.count > 0 {
        self.sequence.remove(at: 0)
      }

      try? self.session.send(heartbeat)

      self.send()
    }
  }

}