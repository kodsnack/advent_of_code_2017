SRC=$(wildcard *.emojic)
BIN=$(SRCS:.emojic=.emojib)

all: $(SRC)
	emojicodec $^

clean:
	rm *.emojib

test: all
	bats *.bats

# %.emojic: %.emojic


# run: all
# 	emojicode day1.emojib
