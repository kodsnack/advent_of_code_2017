import sys
import re
from collections import defaultdict

class State:
    def __init__(self):
        self.ifbranches = {}

    def if_branch(self, value):
        if value in self.ifbranches:
            return self.ifbranches[value]
        else:
            res = IfBranch()
            self.ifbranches[value] = res
            return res


class IfBranch:
    def __init__(self):
        pass


def step1(start_state, diagnostics, states):
    tape = defaultdict(lambda: 0)
    curr_state_name = start_state
    i = 0
    for _ in range(0, diagnostics):
        state = states[curr_state_name]
        value = tape[i]
        if_branch = state.if_branch(value)
        tape[i] = if_branch.write_value
        i += if_branch.delta
        curr_state_name = if_branch.out_state
    return sum(tape.values())


def get_input():
    [start_state] = re.match(r'Begin in state (.)\.', input()).groups()
    [diagnostics] = re.match(r'Perform a diagnostic checksum after (\d+) steps\.', input()).groups()
    diagnostics = int(diagnostics)

    states = {}
    for line in sys.stdin.readlines():
        m = re.match(r'\s*In state (.):.*', line)
        if m:
            s = State()
            [s.state] = m.groups()
            states[s.state] = s
        m = re.match(r'.*If the current value is (\d).*', line)
        if m:
            [if_value] = m.groups()
            if_branch = s.if_branch(int(if_value))
        m = re.match(r'.*Write the value (\d).*', line)
        if m:
            [write_value] = m.groups()
            if_branch.write_value = int(write_value)
        m = re.match(r'.*Move one slot to the (.*)\..*', line)
        if m:
            [direction] = m.groups()
            if_branch.delta = -1 if direction == 'left' else 1
        m = re.match(r'.*Continue with state (.).*', line)
        if m:
            [out_state] = m.groups()
            if_branch.out_state = out_state

    return (start_state, diagnostics, states)


start_state, diagnostics, states = get_input()
print(step1(start_state, diagnostics, states))
# No step 2 for this day
