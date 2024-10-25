# 环境图、高阶函数



### Q1: Warm Up

What is the value of `result` after executing `result = (lambda x: 2 * (lambda x: 3)(4) * x)(5)`? 

30

### Call Expressions 

手画函数栈的图示

---



接下来三个问题是实现一些简单的算法题用来熟悉python高阶函数

### Q2: Make Keeper

```python
def make_keeper(n):
"""Returns a function that takes one parameter cond and prints
out all integers 1..i..n where calling cond(i) returns True.
>>> def is_even(x): # Even numbers have remainder 0 when divided by 2.
... return x % 2 == 0
>>> make_keeper(5)(is_even)
2
4
>>> make_keeper(5)(lambda x: True)
1
2
3
4
5
>>> make_keeper(5)(lambda x: False) # Nothing is printed
"""
def f(cond):
  i = 1
  while i <= n:
  	if cond(i):
  		print(i)
  	i += 1
return f
```

### Q3: Digit Finder

### Q4: Match Maker

