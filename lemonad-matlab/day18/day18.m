%
% Day 18, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

program0 = program(0, 'day18.in', true);
program0.run([]);
first_frequency = program0.getFrequency();
fprintf('Value of the first recovered frequency: %d\n', first_frequency);
assert(first_frequency == 7071)

%
% Part two.
%

program0 = program(0, 'day18.in');
program1 = program(1, 'day18.in');

send_buffer_0 = [];
send_buffer_1 = [];

while ~program0.IsTerminated || ~program1.IsTerminated
    send_buffer_0 = program0.run(send_buffer_1);
    send_buffer_1 = program1.run(send_buffer_0);

    % Deadlock?
    if isempty(send_buffer_0) && isempty(send_buffer_1)
        break
    end
end

counter = program1.getCounter();
fprintf('Times program 1 sent a value: %d\n', counter);
assert(counter == 8001)
