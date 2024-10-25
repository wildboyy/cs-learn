# 递归

一些简单算法题，用python练习递归



## Q5 Seven

```python
def check_seven(i):
    if i % 7 == 0:
        return True
    while i > 0:
        if i % 10 == 7:
            return True
        i //= 10
    return False


def seven(n, k, d, cur, i):
    if n == i:
        return cur
    if check_seven(i):
        d *= -1
    cur += d
    cur = (cur - 1) % k + 1
    i += 1
    return seven(n, k, d, cur, i)
```

