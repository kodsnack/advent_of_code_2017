%
% Day 20, Advent of code 2017 (Jonas Nockert / @lemonad)
%

fp = fopen('day20.in');
data = char(fread(fp));
fclose(fp);
particle_data = textscan(data, 'p=<%f,%f,%f>, v=<%f,%f,%f>, a=<%f,%f,%f>');
particle_data = cell2mat(particle_data);
[M, ~] = size(particle_data);

t = 10000000;
% The kinematic equation for position at time t, given starting
% position p_0, velocity v and acceleration a:
%        p = p_0 + v * t + 1/2 * a * t^2.
positions = particle_data(:, 1:3) + particle_data(:, 4:6) * t + ...
                                   0.5 * particle_data(:, 7:9) * t^2;
[~, pno] = min(vecnorm(positions, 1, 2));
fprintf('Particle closest to position <0,0,0> in the long term: %d\n', pno - 1);
assert(pno - 1 == 258);

%
% Part two.
%

% TODO Figure out how to mass-initialize particles.
foo(M) = particle();
for i = 1:M
    particles(i) = particle(i - 1, particle_data(i, :));
end

for t = 1:100
    pos = containers.Map;

    collisions = [];
    for i = 1:M
        p = particles(i);
        particles(i) = p.tick();
        pos_str = char(sprintf('%d ', particles(i).Pos'));
        if isKey(pos, pos_str)
            collisions = [collisions; i; pos(pos_str)];
        else
            pos(pos_str) = i;
        end
    end
    collisions = unique(collisions);
    particles(collisions) = [];
    M = M - length(collisions);
end

fprintf('Particles left after all collisions are resolved: %d\n', ...
    length(particles));
assert(length(particles) == 707);
