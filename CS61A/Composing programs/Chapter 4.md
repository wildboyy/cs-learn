## 数据处理



## 4.2隐式序列

计算机可以表示序列，而不用将所有序列元素存储在计算机的内存中。也就是说，我们可以构造一个对象，该对象提供对某个顺序数据集的所有元素的访问，而无需事先计算每个元素的值。相反，我们按需计算元素。Python中的range采用的就是这样的技术

按需计算，而不是从现存的内存空间读取，是惰性求值的一个例子。在计算机科学中，惰性求值指的是推迟某个值的计算，直到该值被真正需要。

---

### 4.2.1 Iterators

迭代器，和其他语言中的迭代器一样

### 4.2.2 可迭代对象

任何可以产生迭代器的对象被称作可迭代对象。在python中，任何可以调用iter函数的值被称作可迭代对象，即使是迭代器也被称作可迭代对象，因为迭代器可以调用iter函数 (迭代器调用iter方法返回自身）。Python中的可迭代对象包括strings、tuples、sets和dictionaries等。

### 4.2.3 惰性求值的内置函数

例如map，接收两个参数，一个函数，一个可迭代类型，将迭代器运用到可迭代对象中的每一个元素，并返回一个新的迭代器。

```python
numbers = [1, 2, 3, 4, 5]
squared_numbers = map(lambda x: pow(x, 2), numbers)
print(list(squared_numbers))

# 1,4,9,16,25
```



### 4.2.4 For循环语句

### 4.2.5 可迭代对象的接口

要实现可迭代对象，就必须实现____iter____方法，该方法返回一个迭代器



### 4.2.6 迭代器的接口

迭代器需要实现____next____方法返回序列的下一个元素

### 4.2.7 生成器和yield语句

通过yield语句构建一个生成器函数，Python解释器会帮助我们自动生成一个带有__iter__和__next__方法的生成器对象。

核心是yield语句，yield类似于return，也类似于迭代器的next。用下面的例子体会下。

```python
>>> def fun():
...     a = 1
...     while a <= 10:
...         yield a
...         a += 1
... 
>>> for i in fun():
...     print(i, end="")
... 
12345678910>>> 

```

除了生成器也可以用**生成表达式**

```python
>>> for i in { x for x in range(1,10)}:
...     print(i, end="")
... 
>>>123456789

```



### 4.2.8 使用yield语句创建可迭代对象

用yield语句可以很方便的实现____iter____方法

```python
 def __iter__(self):
            a = 1
            while a < 10:
                yield a
                a += 1

```



### 4.2.9 Streams

### 4.2.10 Python如何实现惰性求值的stream

stream很类似链表，区别在于stream是惰性的

创建stream需要传入数据生成方法。