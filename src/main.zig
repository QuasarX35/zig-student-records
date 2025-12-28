const std = @import("std");
const print = std.debug.print;
const io_utils = @import("io_utils.zig");
const utils = @import("utils.zig");

pub fn main() !void {
    const terminal_size: utils.TerminalSize = try utils.getTerminalSize(std.fs.File.stdout().handle);

    std.debug.print("Terminal Width: {d}, Height: {d}\n", .{ terminal_size.width, terminal_size.height });

    var buffer: [4096]u8 = undefined;

    const width = @min(terminal_size.width, buffer.len - 1) + 1;
    // const width = 14;
    var current_index: usize = 0;

    var line1a = buffer[current_index..width];
    line1a[0] = '+';
    line1a[width - 2] = '+';
    @memset(line1a[1 .. width - 2], '-');
    line1a[width - 1] = '\n';
    current_index += width;

    var line2a = buffer[current_index .. current_index + width];
    line2a[0] = '|';
    line2a[width - 2] = '|';
    const line2a_text = "Main Menu";
    var total_empty_space: usize = width - 1 - 2 - line2a_text.len;
    var index_to_start_text: usize = (total_empty_space / 2) + 1;
    var j: u8 = 0;
    for (1..width - 2) |i| {
        if (i < index_to_start_text) {
            line2a[i] = ' ';
            continue;
        } else if (i > index_to_start_text + line2a_text.len - 1) {
            line2a[i] = ' ';
            continue;
        } else {
            line2a[i] = line2a_text[j];
            j += 1;
        }
    }
    line2a[width - 1] = '\n';
    current_index += width;

    var line3a = buffer[current_index .. current_index + width];
    line3a[0] = '+';
    line3a[width - 2] = '+';
    @memset(line3a[1 .. width - 2], '-');
    line3a[width - 1] = '\n';
    current_index += width;

    var line4a = buffer[current_index .. current_index + width];
    line4a[0] = '|';
    line4a[width - 2] = '|';
    const line4a_text = "1. Create Student Record";
    total_empty_space = width - 1 - 2 - line4a_text.len;
    index_to_start_text = (total_empty_space / 2) + 1;
    j = 0;
    for (1..width - 2) |i| {
        if (i < index_to_start_text) {
            line4a[i] = ' ';
            continue;
        } else if (i > index_to_start_text + line4a_text.len - 1) {
            line4a[i] = ' ';
            continue;
        } else {
            line4a[i] = line4a_text[j];
            j += 1;
        }
    }
    line4a[width - 1] = '\n';
    current_index += width;

    var line9a = buffer[current_index .. current_index + width];
    line9a[0] = '+';
    line9a[width - 2] = '+';
    @memset(line9a[1 .. width - 2], '-');
    line9a[width - 1] = '\n';
    current_index += width;

    const line1 = "+---------------------------+\n";
    const line2 = "|         Main Menu         |\n";
    const line3 = "+---------------------------+\n";
    const line4 = "| 1. Create Student Record  |\n";
    const line5 = "| 2. View Student Records   |\n";
    const line6 = "| 3. Update Student Records |\n";
    const line7 = "| 4. Delete Student Records |\n";
    const line8 = "| 5. Exit                   |\n";
    const line9 = "+---------------------------+\n";
    _ = line1;

    try std.fs.File.stdout().writeAll(line1a);
    try std.fs.File.stdout().writeAll(line2a);
    try std.fs.File.stdout().writeAll(line3a);
    try std.fs.File.stdout().writeAll(line4a);
    try std.fs.File.stdout().writeAll(line9a);
    const menu_string = line2 ++ line3 ++ line4 ++ line5 ++ line6 ++ line7 ++ line8 ++ line9;
    try std.fs.File.stdout().writeAll(menu_string);
}
