from util.knot_hash import ListNode, print_chain

root = ListNode(0,0)
root.prev = root
root.next = root

steps = int(input())

pos = root
for i in range(2017):
    pos = pos.move(steps)
    pos.append(i + 1)
    pos = pos.move(1)
    # print_chain(pos)

print(pos.next.val)

