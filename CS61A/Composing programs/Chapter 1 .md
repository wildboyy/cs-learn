《Composing program》 - 探索编程的艺术

这本书用python教学，深入浅出地讲解了编程的基本概念和原理

融合了[SICP](https://www.baidu.com/s?sa=re_dqa_generate&wd=SICP&rsv_pq=f2f28d62000a9427&oq=composing programs如何&rsv_t=b398jgbRaiBaCiTdH8+yOmvLIiqe3HHIUSCiXyMYoxwzCJnCb60SIjuXw8w&tn=baidu&ie=utf-8)（[Structure and Interpretation of Computer Programs](https://www.baidu.com/s?sa=re_dqa_generate&wd=Structure and Interpretation of Computer Programs&rsv_pq=f2f28d62000a9427&oq=composing programs如何&rsv_t=b398jgbRaiBaCiTdH8+yOmvLIiqe3HHIUSCiXyMYoxwzCJnCb60SIjuXw8w&tn=baidu&ie=utf-8)）的精髓

本书大概等于 = 用python改编的SICP

---

# 第 1 章：使用函数构建抽象

---

## 1.1 入门

安装python3

计算机 = 强大 + 愚蠢

计算机有强大的执行能力，没有丝毫的洞察力

编程就是一个人用他们真正的洞察力来构建一些有用的东西，并交给计算机执行



## 1.2 编程要素

编程语言不仅仅是一种指示计算机执行任务的手段。语言还是一种框架，我们可以通过它来组织有关计算过程的想法。程序用于在编程社区成员之间交流这些想法。因此，程序必须供人阅读，而仅供机器偶尔执行。

表达式：+ - * /

调用：power(2,2)

库函数: from math import sqrt

名称和环境: 将名称绑定到值并稍后通过名称检索这些值的可能性意味着解释器必须维护某种内存来跟踪名称、值和绑定。这种内存称为环境。

计算嵌套表达式：

纯函数与非纯哈数：例如max & print



## 1.3 定义新函数

作用域：可以用函数栈理解

python命名规范：

- 函数名小写，单词之间下划线分割
- 参数名小写，单词之间下划线分割
- 任何名称最好都能表示该参数的含义
- ……

函数抽象：函数隐藏细节，调用者不必关心其细节。

操作符：+ - * /这些，和其他语言差不多，需要注意Python3中有两种除法，/ 结果为浮点数，// 结果为向下取整

对于 / 和 //，python3中有对应的函数truediv和floordiv



## 1.4 设计函数

什么是好的函数？

- 函数应该只执行一个任务
- BRY原则：不要重复自己
- 函数应该被普遍定义：例如，square函数不会被定义，因为它是pow函数的一个特例。

### 1.4.1 函数文档

文档

```python
def add(a, b):
	""" 第一行简单描述函数的功能
	
	以下几行描述参数并阐明函数的行为
	a - 加数
	b - 被加数
	返回 a+b
	"""
	return a + b;
```

注释

```python
# 注释
```

文档可以通过 help 命令显示出来，注释不行

```python
>>> help(add)
```



### 1.4.2 默认参数值

python中可以给参数默认值

```python
def add(a, b, c = 1):
		return a + b + c
```

调用的时候不填入c，则默认使用0

```python
add(1,2) # 4
add(1,2,3) # 6
```





## 1.5 控制

条件语句和循环

```python
if boolexpr1:
	xxx
elif boolexpr2:
	xxx
else:
	xxx
  
k = 1
while k < 3:
	k = k + 1
return curr
```

复合语句：例如if-else中的语句，python中不用括号来进行复合，而是用缩进，相同缩进的为一个复合语句

局部赋值, 作用域



**测试：**

assert

```python
def fib_test():
        assert fib(2) == 1
        assert fib(3) == 1
```

doctest

```python
>>> def sum_naturals(n):
        """Return the sum of the first n natural numbers.

        >>> sum_naturals(10)
        55
        >>> sum_naturals(100)
        5050
        """
        total, k = 0, 1
        while k <= n:
            total, k = total + k, k + 1
        return total
```

可以测试整个py文件，也可以对文件中的某个函数测试



## 1.6 高阶函数

python中的高阶函数指的是，可以接受函数作为参数，或者将函数作为返回值的函数。

> 高阶函数是强大的抽象机制，能大大增强语言的表达能力

例如：求数列和，不同的数列和都共享同一模式（如下）

```python
def <name>(n):
    total, k = 0, 1
    while k <= n:
        total, k = total + <term>(k), k + 1
    return total
```

通过高阶函数，将通项公式作为该模式的参数，既可实现任意数列的求和函数！！

c++和java中都没有严格意义上的高阶函数，但是他们各自都能一定程度上实现高阶函数的功能

c++例如sort（）函数，函数指针，函数类

Java中的lambda表达式，函数类



### 1.6.2 函数作为通用方法

函数是一个计算过程，他独立于所给的参数，无论给的参数具体是多少，都应该正确运行。

高阶函数是一个通用的过程（方法），独立于所调用的函数，无论给的是什么函数，都应该正确运行



### 1.6.3嵌套定义

```python
>>> def sqrt(a):
        def sqrt_update(x):
            return average(x, a/x)
        def sqrt_close(x):
            return approx_eq(x * x, a)
        return improve(sqrt_update, sqrt_close)
```



### 1.6.4 函数作为返回值



### 1.6.6 咖喱函数

在函数式编程中，“咖喱函数”（Curried function）是一种将多参数函数转化为一系列单参数函数的技术。

```python
>>> def curried_pow(x):
        def h(y):
            return pow(x, y)
        return h
>>> curried_pow(2)(3)
8
```



### 1.6.7 lambda表达式

当函数作为一个中间变量，仅仅使用一次，不想给函数命名的话，可以用lambda表达式。

`在 Python 中，我们可以使用``lambda`表达式动态创建函数值 ，该表达式求值为未命名的函数。lambda 表达式求值为具有单个返回表达式作为其主体的函数。不允许使用赋值和控制语句。

```python
def compose(f, g):
	return lambda x: f(g(x))
```



### 1.6.8 抽象与一等函数

> 作为程序员，我们应该时刻警惕，抓住机会识别程序中的底层抽象，在此基础上进行构建，并对其进行概括以创建更强大的抽象。这并不是说人们应该总是以最抽象的方式编写程序；专业程序员知道如何选择适合其任务的抽象级别。但能够从这些抽象的角度思考很重要，这样我们就可以随时将它们应用于新的环境中。高阶函数的重要性在于，它们使我们能够将这些抽象明确地表示为编程语言中的元素，以便可以像处理其他计算元素一样处理它们。



一般来说，编程语言会对计算元素的操作方式施加限制。限制最少的元素被称为具有一等地位。一等元素的一些“权利和特权”包括：

1. 它们可能与名称绑定。
2. 它们可以作为参数传递给函数。
3. 它们可以作为函数的结果返回。
4. 它们可能包含在数据结构中。

Python 授予函数完全的一流地位，由此带来的表达能力的提升是巨大的。



### 1.6.9 函数装饰器

类似于java的注解

```python
>>> def trace(fn):
        def wrapped(x):
            print('-> ', fn, '(', x, ')')
            return fn(x)
        return wrapped
>>> @trace
    def triple(x):
        return 3 * x
>>> triple(12)
->  <function triple at 0x102a39848> ( 12 )
36
```

上述代码等效于

```python
>>> def triple(x):
        return 3 * x
>>> triple = trace(triple)

```

