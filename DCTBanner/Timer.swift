
import Foundation

class Timer {

	private let source: dispatch_source_t
	init(timeInterval: NSTimeInterval, block: dispatch_block_t, queue: dispatch_queue_t = dispatch_get_main_queue()) {
		source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
		let delta = UInt64(timeInterval) * NSEC_PER_SEC
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delta))
		dispatch_source_set_timer(source, time, delta, 0);
		dispatch_source_set_event_handler(source, block)
		dispatch_resume(source)
	}

	deinit {
		dispatch_source_cancel(source)
	}
}
