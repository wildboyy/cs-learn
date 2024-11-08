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
  
  for (int i = 0; i < n; i++) {
    	int a = nums[i];
    	// 从子数组nums(0,i-1)中找有没有 sum - a
    	if (map[sum - a] == 1) return [map[sum - a], ]
    	// 将a记入map，如果用重复直接覆盖就行
    	map[a] = i;
  }
```

