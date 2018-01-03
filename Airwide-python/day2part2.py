checksum = 0
with open("day2.in") as file:
    for line in file:
        list_nums = list(map(int, line.split()))
        for i in range(len(list_nums)):
            sub_list = list_nums[:]
            value = sub_list.pop(i)
            for item in sub_list:
                if item % value == 0:
                    result = item / value
                    break
        print("Line result: ", result)
        checksum += result
print("Checksum: ", checksum)
