package day18

import "sync"

type Queue struct {
	values []int
	mutex  *sync.Mutex
}

func NewQueue() *Queue {
	q := new(Queue)
	q.mutex = new(sync.Mutex)
	q.values = make([]int, 0)
	return q
}

func (q *Queue) Push(i int) {
	q.mutex.Lock()
	defer q.mutex.Unlock()
	q.values = append(q.values, i)
}

func (q *Queue) Pop() int {
	q.mutex.Lock()
	defer q.mutex.Unlock()
	i := q.values[0]
	if len(q.values) == 1 {
		q.values = make([]int, 0)
	} else {
		q.values = q.values[1:]
	}
	return i
}

func (q *Queue) Empty() bool {
	q.mutex.Lock()
	defer q.mutex.Unlock()
	return len(q.values) == 0
}
