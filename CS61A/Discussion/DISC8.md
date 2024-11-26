# Q1 StrangeLoop

构建一个奇怪的循环链表，如下

head.rest.first.rest = head





# Q2 Sum Two Ways

分别用迭代和递归两种方式对链表求和

思考其求和的顺序

答：迭代是从前往后求和，递归是从后往前求和





# Q3 Overlap

两个链表s，t，都是增序的，每个链表都没有重复值，统计两个链表中相同数字的个数

递归：

```python
 if s is Link.empty or t is Link.empty:
        return 0
    if s.first == t.first:
        return __________________
    elif s.first < t.first:
        return __________________
    elif s.first > t.first:
        return __________________
```

迭代：

```python
    k = 0
    while s is not Link.empty and t is not Link.empty:
        if s.first == t.first:
            __________________
        elif s.first < t.first:
            __________________
        elif s.first > t.first:
            __________________
    return k
```





# Q4: Overlap Growth

当s,t乱序时，求以下算法的时间复杂度

```python
def length(s):
    if s is Link.empty:
        return 0
    else:
        return 1 + length(s.rest)

def filter_link(f, s):
    if s is Link.empty:
        return s
    else:
        frest = filter_link(f, s.rest)
        if f(s.first):
            return Link(s.first, frest)
        else:
            return frest

def contained_in(s):
    def f(s, x):
        if s is Link.empty:
            return False
        else:
            return s.first == x or f(s.rest, x)
    return lambda x: f(s, x)

def overlap(s, t):
    """For s and t with no repeats, count the numbers that appear in both.

    >>> a = Link(3, Link(4, Link(6, Link(7, Link(9, Link(10))))))
    >>> b = Link(1, Link(3, Link(5, Link(7, Link(8, Link(12))))))
    >>> overlap(a, b)  # 3 and 7
    2
    >>> overlap(a.rest, b.rest)  # just 7
    1
    >>> overlap(Link(0, a), Link(0, b))
    3
    """
    return length(filter_link(contained_in(t), s))
```



平方复杂度





# Q5: Decimal Expansion

用链表构建小数的表示

1/22 = 0.04545454545..

```python
x = Link(0, Link(0, Link(4, Link(5))))
x.rest.rest.rest.rest = x.rest.rest
```

