import time


def system_time():
    now = time.time()
    seconds = int(now)
    nanoseconds = int((now - seconds) * 1_000_000_000)
    return (seconds, nanoseconds)


def local_time_offset_seconds():
    local = time.localtime()
    offset = getattr(local, "tm_gmtoff", None)
    if offset is not None:
        return int(offset)
    return -int(time.altzone if local.tm_isdst else time.timezone)