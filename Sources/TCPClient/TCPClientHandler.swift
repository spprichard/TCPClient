import Foundation
import NIO

class TCPClientHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    typealias OutboundOut = ByteBuffer
    private var numBytes = 0
    
    func channelActive(ctx: ChannelHandlerContext) {
        let message = "SwiftNIO rocks"
        var buffer = ctx.channel.allocator.buffer(capacity: message.utf8.count)
        buffer.write(string: message)
        ctx.writeAndFlush(wrapOutboundOut(buffer), promise: nil)
    }
    
    func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
        var buffer = unwrapInboundIn(data)
        let readableBytes = buffer.readableBytes
        if let received = buffer.readString(length: readableBytes) {
            print(received)
        }
        
        if numBytes == 0 {
            print("Nothing left to read, close channel")
            ctx.close(promise: nil)
        }
    }
    
    func errorCaught(ctx: ChannelHandlerContext, error: Error) {
        print("error: \(error.localizedDescription)")
        ctx.close(promise: nil)
    }
}

