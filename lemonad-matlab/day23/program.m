%%%%% Also see day 18, using send and receive buffers.
classdef program < handle
    properties (Access = private)
        ProgId
        Instructions
        Registers
        IP
        RecvBuffer
        MulCounter
    end
    
    properties
        IsTerminated
    end

    methods
        function p = program(prog_id, filename, n_registers)
            if nargin < 3
                n_registers = 16;
            end
            p.ProgId = prog_id;
            p.Registers = zeros(1, n_registers, 'double');
            p.IsTerminated = false;
            p.IP = 1;
            
            content = fileread(filename);
            p.Instructions = splitlines(strtrim(content));

            p.MulCounter = 0;
        end

        function run(p)
            if p.IsTerminated
                return
            end
            
            N = length(p.Instructions);
            while p.IP > 0 && p.IP <= N
                line = char(p.Instructions(p.IP));
                ops = textscan(line, '%s %s %s');
                operation = char(ops{1});
                [value1, reg1_index] = p.parseOperand(ops{2});
                if ~isempty(ops{3})
                    [value2, ~] = p.parseOperand(ops{3});
                end
                
                switch operation
                    case 'set'
                        p.Registers(reg1_index) = value2;
                    case 'sub'
                        p.Registers(reg1_index) = p.Registers(reg1_index) - value2;
                    case 'mul'
                        p.Registers(reg1_index) = p.Registers(reg1_index) * value2;
                        p.MulCounter = p.MulCounter + 1;
                    case 'jnz'
                        if value1 ~= 0
                            % -1 since we add one to IP at end of loop.
                            p.IP = p.IP + value2 - 1;
                        end
                    otherwise
                        fprintf('Error, unknown operation = "%s".\n', operation);
                        break
                end
                p.IP = p.IP + 1;
            end

            % Terminate program, e.g. IP outside valid instruction space.
            p.IsTerminated = true;
        end
        
        function counter = getCounter(p)
            counter = p.MulCounter;
        end
    end
    
    methods (Access = private)
        function [value, register_index_or_zero] = parseOperand(p, operand)
            function index = reg2Index(reg)
                index = reg - 'a' + 1;
            end
        
            operand = char(operand);
            match = textscan(operand, '%f');
            if isempty(match{1})
                match = textscan(operand, '%c');
                register_index_or_zero = reg2Index(match{1});
                value = p.Registers(register_index_or_zero);
            else
                register_index_or_zero = 0;
                value = match{1};
            end
        end
    end
end
