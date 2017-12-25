%%%%% 
classdef program < handle
    properties (Access = private)
        ProgId
        Instructions
        Registers
        IP
        RecvBuffer
        SetCounter
        Frequency
        ExitOnFrequency
    end
    
    properties
        IsTerminated
    end

    methods
        function p = program(prog_id, filename, exit_on_frequency)
            if nargin < 3
                exit_on_frequency = false;
            end
            p.ProgId = prog_id;
            p.Registers = zeros(1, 16, 'double');
            p.Registers(16) = prog_id;
            p.IsTerminated = false;
            
            content = fileread(filename);
            p.Instructions = splitlines(strtrim(content));

            p.IP = 1;
            p.Frequency = 0;
            p.ExitOnFrequency = exit_on_frequency;
            p.SetCounter = 0;
            p.RecvBuffer = [];
        end

        function send_buffer = run(p, recv_buffer)
            if p.IsTerminated
                return
            end

            % Prepend receive buffer (newest value first).
            p.RecvBuffer = [flipud(recv_buffer); p.RecvBuffer];
            send_buffer = [];
            
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
                    case 'mul'
                        p.Registers(reg1_index) = p.Registers(reg1_index) * value2;
                    case 'jgz'
                        if value1 > 0
                            p.IP = p.IP + value2;
                            continue
                        end
                    case 'add'
                        p.Registers(reg1_index) = p.Registers(reg1_index) + value2;
                    case 'mod'
                        p.Registers(reg1_index) = mod(p.Registers(reg1_index), value2);
                    case 'snd'
                        p.Frequency = value1;
                        send_buffer = [send_buffer; value1];
                        p.SetCounter = p.SetCounter + 1;
                    case 'rcv'
                        if p.ExitOnFrequency
                            if value1 ~= 0
                                break
                            end
                        else
                            if isempty(p.RecvBuffer)
                                return
                            else
                                p.Registers(reg1_index) = p.RecvBuffer(end);
                                p.RecvBuffer = p.RecvBuffer(1:end - 1);
                            end
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
            counter = p.SetCounter;
        end

        function freq = getFrequency(p)
            freq = p.Frequency;
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
