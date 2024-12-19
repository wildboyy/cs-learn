# 第三章：解释器

## 

## 3.1 简介

焦于程序代码本身，解释器是如何对代码进行解释求值以及执行

---

### 3.1.1 解释器的结构

很多解释器都拥有一个优雅而共同的结构：两个相互递归的函数

1. 求值器：在环境中对表达式进行求值。
2. 函数应用：将参数应用到函数中。





## 3.2 函数式编程语言Scheme

本节我们将介绍函数式编程语言Scheme的一个子集，它和Python的计算模型十分类似，但是只使用表达式，不允许使用语句，只使用不可变数据。

---

### 3.2.1 表达式

```scheme
(if <predicate> <consequent> <alternative>)
```



### 3.2.2 定义表达式

```scheme
(define pi 3.14)
```

函数定义：

```scheme
(define (<name> <formal parameters>) <body>)
```

Scheme和python一样支持函数的嵌套定义，也使用词法作用域。

```scheme
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
(sqrt 9)
3.00009155413138
```

可以使用lambda表达式创建匿名函数，用法如下

```scheme
(lambda (<formal-parameters>) <body>)
(define (plus4 x) (+ x 4))
(define plus4 (lambda (x) (+ x 4)))
((lambda (x y z) (+ x y (square z))) 1 2 3)
```



### 3.2.3 Scheme如何构建复合数据

**Scheme使用cons函数构建复合数据。**

```scheme
(define x (cons 1 2))
x
(1 . 2)
(car x)
1
(cdr x)
2
```

构建了一个pair，pair中的元素为 car 和 cdr



**Scheme内置了list**

nil或者'()表示空的list，其中单引号'表示引用一个常亮，（）表示空列表

```scheme
(cons 1
      (cons 2
            (cons 3
                  (cons 4 nil))))
(1 2 3 4)
(list 1 2 3 4)
(1 2 3 4)
(define one-through-four (list 1 2 3 4))
(car one-through-four)
1
(cdr one-through-four)
(2 3 4)
(car (cdr one-through-four))
2
(cons 10 one-through-four)
(10 1 2 3 4)
(cons 5 one-through-four)
(5 1 2 3 4)
```

就是一堆嵌套pair



**可以使用null?内置函数判断list是否为空。**

```scheme
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define (getitem items n)
  (if (= n 0)
      (car items)
      (getitem (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(length squares)
5
(getitem squares 3)
16
```





### 3.2.4 Symbolic Data

Scheme使用引号来标识字符类型。

```scheme
(define a 1)
(define b 2)
(list a b)
(1 2)
(list 'a 'b)
(a b)
(list 'a b)
(a 2)
```

引号除了标识字符类型，还用于标识复合数据。

```scheme
(car '(a b c))
a
(cdr '(a b c))
(b c)
```







## 3.3 Python异常处理

exception是继承于BaseException类的对象实例，通常可以使用raise语句触发异常处理，并且显示出异常触发的堆栈信息。

```python
>>> raise Exception('An error occurred')
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
Exception: an error occurred
```



异常可以通过try语句来处理，当 <try suite>中的语句触发了<exception class>，那么就会将exception对象实例绑定到name，然后执行<except suite>中的语句。

```python
try:
    <try suite>
except <exception class> as <name>:
    <except suite>
```

e.g.
```python
>>> try:
			x = 1/0
		except ZeroDivisionError as e:
			print('handling a', type(e))
			x = 0
handling a <class 'ZeroDivisionError'>
>>> x
0
```



用户可以自定义异常类，并且在类中自定义一些属性。

```python
class IterImproveError(Exception):
		def __init__(self, last_guess):
				self.last_guess = last_guess
```





## 3.4 Interpreters for Languages with Combination

这节我们将学习如何基于其他语言创建新的语言，首先我们需要进行元语言抽象，然后根据抽象构建解释器。我们将首先实现Scheme子集的解释器，并实现第一章提到的求值环境模型。

---



### 3.4.1 A Scheme-Syntax Calculator

解释器首先要解决的是对Scheme支持的算术表达式的求值，即如何对下列表达式求值，包括加法、减法、乘法和除法等，这些运算都需要支持任意个参数，其中“-”有两种含义，减法运算符和取负数。

```scheme
> (+ 1 2 3 4)
10
> (+)
0
> (* 1 2 3 4)
24
> (*)
1
> (- 10 1 2 3)
4
> (- 3)
-3
> (/ 15 12)
1.25
> (/ 30 5 2)
3
> (/ 10)
0.1
```

要对上述的字符串求值，那么我们需要将这些字符串通过**词法分析**拆分成一个个单独的元素，然后进行**语法分析**，确定求值顺序，最后生成一个表达式树



### 3.4.3 解析表达式

**词法分析器：**

将字符串分解为一个符号序列，由scheme_tokens中的tokenize_line函数作为词法分析器，词法分析是一个迭代过程，需要对每一行进行分析，示例如下。

```scheme
>>> tokenize_line('(+ 1 (* 2.3 45))')
['(', '+', 1, '(', '*', 2.3, 45, ')', ')']
```



**语法分析器**：

将符号序列转化为表达式树。语法分析是树形递归的过程，还需要考虑到完整表达式横跨多行的情况。语法分析由[scheme_reader](http://composingprograms.com/examples/scalc/scheme_reader.py.html)中的**scheme_read**函数实现

```scheme
>>> lines = ['(+ 1', '   (* 2.3 45))']
>>> expression = scheme_read(Buffer(tokenize_lines(lines)))
>>> expression
Pair('+', Pair(1, Pair(Pair('*', Pair(2.3, Pair(45, nil))), nil)))
>>> print(expression)
(+ 1 (* 2.3 45))
```



### 3.4.4 计算器求值

lab10 的内容





### 3.5 支持抽象的语言的解释器

前面实现的计算器语言没有提供定义新运算符、给变量命名以及过程抽象的方式，它不支持任何抽象方式。不足以作为一个通用的编程语言。本节我们将实现一个支持抽象的通用编程语言scheme的解释器。

---

#### 3.5.1 Scheme解释器程序的结构

Scheme解析器：代码转为抽象语法树

Scheme求值器：语法树求值



#### 3.5.2 Environments

在Scheme的解释器中，我们还需要实现环境求值模型。我们使用Frame类保存变量名和变量值的键值对。存取键值需要使用lookup和define函数。



#### 3.5.3 数据即程序

不去区分程序和数据，有时可能会更加方便，毕竟数据和程序的界限本身就不是和清晰。例如在python中，可以直接执行一段字符串（如果这个字符串是语法正确的）

```python
>>> eval('2+2')
4
```

and

```python
>>> 2+2
4
```