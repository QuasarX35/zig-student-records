const std = @import("std");
const testing = std.testing;

pub const UserInputError = error{
    StreamTooLong,
    ReadFailed,
    EndOfStream,
    InputEmpty,
};

pub fn getUserInput(input_buffer: []u8) UserInputError![]u8 {
    var stdin_reader = std.fs.File.stdin().reader(input_buffer);
    const stdin = &stdin_reader.interface;

    const input = try stdin.takeDelimiterExclusive('\n');
    if (input.len == 0) return UserInputError.InputEmpty;
    return input;
}
