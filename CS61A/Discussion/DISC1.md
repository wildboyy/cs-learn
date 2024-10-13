# 控制，环境

通过一些题目练习python中的if 和 while



## while & if

### Q1 龟兔赛跑

```python
def race(x, y):
  """The tortoise always walks x feet per minute, while the hare repeatedly
  runs y feet per minute for 5 minutes, then rests for 5 minutes. Return how
  many minutes pass until the tortoise first catches up to the hare.
  >>> race(5, 7) # After 7 minutes, both have gone 35 steps
  7
  >>> race(2, 4) # After 10 minutes, both have gone 20 steps
  10
  """
  assert y > x and y <= 2 * x, 'the hare must be fast but not too fast'
  tortoise, hare, minutes = 0, 0, 0
  while minutes == 0 or tortoise - hare:
    tortoise += x
    if minutes % 10 < 5:
    	hare += y
  minutes += 1
  return minutes
```

题目要求：找到一对 <x,y> ，使得答案错误，或者死循环

解析：代码中判断的是所有整数时刻乌龟和兔子的位置，但是乌龟可能在非整数分钟的时候追到兔子

所以 输入为（4,6）时，会得到错误答案。

输入为（11,19）时，会陷入死循环



### Q2 数字游戏 - fizzbuzz

实现fizzbuzz

```python
def fizzbuzz(n):
    i = 1
    while i <= n:
        if i % 15 == 0:
            print('fizzbuzz')
        elif i % 3 == 0:
            print('fizz')
        elif i % 5 == 0:
            print('buzz')
        else:
            print(i)
        i += 1
```



## 解决问题

### Q3 素数判断

### Q4 唯一数字

都是简单的题目，刷刷力扣就好了



## 环境图

一些作用域相关的问题
