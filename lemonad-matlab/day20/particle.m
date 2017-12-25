classdef particle < handle
    properties
        Id
        Pos = [0; 0; 0];
        Vel = [0; 0; 0];
        Acc = [0; 0; 0];
        Destroyed = false;
    end

    methods
        function p = particle(id, particle_data)
            if nargin == 0
                id = 0;
                particle_data = [0,0,0,0,0,0,0,0,0];
            end
            p.Id = id;
            p.Pos = [particle_data(1); particle_data(2); particle_data(3)];
            p.Vel = [particle_data(4); particle_data(5); particle_data(6)];
            p.Acc = [particle_data(7); particle_data(8); particle_data(9)];
        end
        
        function p = tick(p)
            p.Vel = p.Vel + p.Acc;
            p.Pos = p.Pos + p.Vel;
        end
        
        function dist = manhattan_distance(p)
            if p.Destroyed
                dist = 100000000;
            else
                dist = sum(abs(p.Pos));
            end
        end
    end
end
