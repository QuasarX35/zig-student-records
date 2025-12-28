const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectError = std.testing.expectError;
const c = @cImport({
    @cInclude("sys/ioctl.h");
    @cInclude("unistd.h");
});

pub const DigitCountError = error{
    ZeroError,
    NumberTooBig,
};

pub fn countDigits(number: i128) DigitCountError!u8 {
    if (number == 0) return DigitCountError.ZeroError;
    if (number > std.math.maxInt(u64)) return DigitCountError.NumberTooBig;

    const absoluteValue = @abs(number);
    const result: u8 = std.math.log10_int(absoluteValue) + 1;
    return result;
}

test "countDigits 1" {
    const digits = countDigits(5);
    try expectEqual(1, digits);
}

test "countDigits 3" {
    const digits = countDigits(420);
    try expectEqual(3, digits);
}

test "countDigits 10" {
    const digits = countDigits(1234567890);
    try expectEqual(10, digits);
}

test "countDigits 0" {
    const digits = countDigits(0);
    try expectError(DigitCountError.ZeroError, digits);
}

test "countDigits negative" {
    const digits = countDigits(-6);
    try expectEqual(1, digits);
}

test "countDigits negative multiple" {
    const digits = countDigits(-100);
    try expectEqual(3, digits);
}

test "countDigits number too big" {
    const digits = countDigits(20_000_000_000_000_000_000);
    try expectError(DigitCountError.NumberTooBig, digits);
}

pub const TerminalSize = struct {
    height: u16,
    width: u16,
};

pub fn getTerminalSize(tty: std.posix.fd_t) !TerminalSize {
    var winsz = c.winsize{ .ws_col = 0, .ws_row = 0, .ws_xpixel = 0, .ws_ypixel = 0 };

    // ioctl returns a 0 on success
    const rv = std.c.ioctl(tty, c.TIOCGWINSZ, @intFromPtr(&winsz));

    if (rv == 0) {
        return TerminalSize{ .height = winsz.ws_row, .width = winsz.ws_col };
    } else {
        return error.IoctlFailed;
    }
}
