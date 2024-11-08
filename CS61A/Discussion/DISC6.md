# 迭代器 & 生成器

iter & yield



## Q1: Big Fib

**1、有以下函数**

```python
def gen_fib():
    n, add = 0, 1
    while True:
        yield n
        n, add = n + add, n
```



**2、解释下列语句**

```python
(lambda t: [next(t) for _ in range(10)])(gen_fib())
```

左半部分的lambda表达式可以看做一个函数

```python
def fun(iter):
		for _ in range(10):
				next(iter)
```

右半部分就是函数调用的参数

```python
fun(gen_fib())
```

而``gen_fib()``是一个生成器，所以会生成十次fib数



**3、填入函数使得，返回第一个大于2024的斐波那契数字**

```python
next(____(lambda n: n > 2024, ____))
```

`filter & fib_gen()`



## Q2: Something Different

easy





## Q3: Partitions

`partition_gen(n, m)`: 所有n的分解序列的生成器，分解序列是一系列加法，每个加数不超过m，加数从小到大排序

例如：

```python
partition_gen(3 , 2) 
会生成 ：'2 + 1','1 + 1 + 1'
```

yield from：将另一个可迭代对象（通常是另一个生成器）的元素 “委托” 给当前生成器。

```python
def partition_gen(n, m):
    """Yield the partitions of n using parts up to size m.

    >>> for partition in sorted(partition_gen(6, 4)):
    ...     print(partition)
    1 + 1 + 1 + 1 + 1 + 1
    1 + 1 + 1 + 1 + 2
    1 + 1 + 1 + 3
    1 + 1 + 2 + 2
    1 + 1 + 4
    1 + 2 + 3
    2 + 2 + 2
    2 + 4
    3 + 3
    """
    assert n > 0 and m > 0
    if n == m:
        yield str(n)
    if n - m > 0:
        for p in partition_gen(n - m, m):
            yield p + ' + ' + str(m)
    if m > 1:
        yield from partition_gen(n, m-1)
```

**注意：**在递归结构的生成器函数中，需要在递归除使用yield from，否则如下

```python
def fun(n)
		if n == 1:
				yield n
		else:
				yield n
				fun(n - 1)
        
>>> a = [x for x in fun(10)]
>>> a
>>> [10]   # 并没有生成1-10，fun(n - 1)内的数字不会yield
```