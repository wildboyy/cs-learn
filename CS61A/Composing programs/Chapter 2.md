# 第2章：使用数据构建抽象

数据。使我们能够表示和操纵有关许多不同领域的信息。有效使用内置和用户定义的数据类型是数据处理应用程序的基础。

---

## 2.1 简介

### 2.1.1 原生数据类型

Python 包含三种原生数字类型：整数 ( `int` )、实数 ( `float` ) 和复数 ( `complex` )。

```python
>>>1 + 10000000000000
10000000000001
>>>type( 1.5 ) 
<class 'float'> 
>>>type( 1 + 1 j ) 
<class 'complex'>
```



## 2.2 数据抽象

数据抽象的基本思想是构造程序，使其对抽象数据进行操作。也就是说，我们的程序应该以尽可能少对数据做出假设的方式使用数据。同时，具体的数据表示被定义为程序的独立部分。



### 2.2.3  Abstraction Barriers（抽象屏障）

假设有理数作为一个抽象类型，不同层级使用不同程度的抽象

| 程序层级               | 将有理数视为  | 使用                     |
| ---------------------- | ------------- | ------------------------ |
| 使用有理数计算         | 整体          | mul_rational：有理数乘法 |
| 构造有理数对象，并管理 | 分子和分母    | rational，numer，denom   |
| 用于实现有理数的工具   | 长度为2的数组 | 数组操作                 |



在上面的每一层中，最后一列中的函数都强制执行抽象屏蔽。这些函数由较高级别调用，并使用较低级别的抽象实现。

当程序中可以使用更高级别函数的部分改用较低级别的函数时，就会发生抽象屏障违规。例如，计算有理数平方的函数最好用`mul_rational`来实现，它不对有理数的实现做任何假设。

```python
>>> def  square_rational ( x ):
return mul_rational ( x , x )          
```

直接引用分子和分母会打破一层抽象屏蔽。

```python
>>> def  square_rational_violating_once ( x ):
return rational ( numer ( x ) * numer ( x ), denom ( x ) * denom ( x ))              
```

假设有理数表示为双元素列表，并且直接使用数组操作，将会打破两层抽象。

```python
>>> def  square_rational_violating_twice ( x ):
return [ x [ 0 ] * x [ 0 ], x [ 1 ] * x [ 1 ]]              
```

抽象屏障使程序更易于维护和修改。依赖于特定表示的函数越少，当想要更改该表示时所需的更改就越少。square_rational 的所有这些实现都具有正确的行为，但只有第一个对未来的更改具有鲁棒性。即使我们改变了有理数的表示， `square_rational`函数也不需要更新。相比之下，只要选择器或构造函数签名发生变化， `square_rational_violating_once`就需要更改，而 只要有理数的实现发生变化`，``square_rational_violating_twice`就需要更新。





## 2.3 序列

序列是计算机科学中一个强大的基本抽象概念，是几种不同类型的数据之间共享的行为的集合

python中有一些内置的数据类型，属于序列



### 2.3.1 列表

```python
>>>num =  [ 1 ,  8 ,  2 ,  8 ] 
>>> len (num) 
4 
>>>num[ 3 ] 
8
>>> [ 2 ,  7 ]  + num *  2 
[2, 7, 1, 8, 2, 8, 1, 8, 2, 8]
>>>pair =  [[ 10 ,  20 ],  [ 30 ,  40 ]] 
>>>pair[ 1 ] 
[30, 40] 
>>>pair[ 1 ][ 0 ] 
30
```

### 2.3.2 序列迭代

**Range。**range是 Python 中另一种内置的序列类型，表示整数范围。Range由 range 创建,接受两个整数参数：左边界（闭） & 右边界（开）

如果只给一个参数，则默认为右边界，左边界为0

```python
>>> range ( 1 ,  10 )   # 包括 1，但不包括 10 
range(1, 10)

>>> list(range(4))
[0, 1, 2, 3]

>>> list(range(-1)) # 返回空序列，range默认的step为1, 则0永远无法迭代到-1
[]

>>> list(range(0,-2,-1)) # 设定迭代向量为-1，则可以生成序列
[0, -1]

>>> list(range(5, 8))
[5, 6, 7]
```

常见的约定是，在`for标头中对名称使用单个下划线字符：`如果不使用name

```python
>>> for _ in range(3): 
        print('加油！')
```



### 2.3.3  序列处理



python 序列表达式

```python
>>> odds = [1, 3, 5, 7, 9]
>>> [x+1 for x in odds]
[2, 4, 6, 8, 10]
```

python 序列聚合

```python
>>> def divisors(n):
        return [1] + [x for x in range(2, n) if n % x == 0]
>>> divisors(4)
[1, 2]
```

```python
>>> [[1] + s for s in [[4], [5, 6]]]
 [[1,4],[1,5,6]]
```

python 序列 + 高阶函数

```python
>>> [abs(x) for x in [-1,2] ]
[1, 2]
```





### 2.3.4 序列抽象

**成员资格。** 可以测试某个值是否属于某个序列。Python 有两个运算符`in`和`not in` ， 根据元素是否出现在序列中，它们的计算结果为`True`或`False 。`

```python
>>> digits
[1, 8, 2, 8]
>>> 2 in digits
True
>>> 1828 not in digits
True
```



**切片。**序列中包含较小的序列。序列的*切片*是原始序列的任意连续跨度，由一对整数指定。与`范围`构造函数一样，第一个整数表示切片的起始索引，第二个整数表示超出结束索引的索引。

在 Python 中，序列切片的表达方式与元素选择类似，使用方括号。冒号分隔起始索引和终止索引。任何省略的边界都被视为极值：起始索引为 0，终止索引为序列的长度。

```python
>>>digits[ 0 : 2 ] 
[1, 8] 
>>>digits[ 1 :] 
[8, 2, 8]
```



### 2.3.5 字符串

字符串文字可以表达任意文本，用单引号或双引号括起来。

```python
>>> city  =  'Berkeley' 
>>> len ( city ) 
8 
>>> city [ 3 ] 
'k'
```

加法 & 乘法

```python
>>> 'Berkeley' + ', CA'
'Berkeley, CA'
>>> 'Shabu ' * 2
'Shabu Shabu '
```



成员函数

```python
>>> 'here' in 'where'
True	
```

**多行文字。**字符串不限于一行。三重引号分隔跨多行的字符串文字。我们已经在文档字符串中广泛使用了这种三重引号。

```python
>>> """ hi
 hi"""
' hi\nhi'
```

**字符串强制转换**

```python
>>> str(2) + ' is an element of ' + str(digits)
'2 is an element of [1, 8, 2, 8]'
```

### 2.3.6  树

用list 递归构造

### 2.3.7 链表

用list 递归构造



## 2.4 可变数据

介绍python的对象

### 2.4.1 对象

python中有对象的概念，可以通过class关键词来创建类，对象为类的实例。

python中的字符串，列表都是对象，都可以在源码中找到其对应的class

```python
# 字符串对象的一些方法
>>> '1234' . isnumeric () 
True 
>>> 'rOBERT dE nIRO' . swapcase () 
'Robert De Niro' 
>>> 'eyes' . upper () . endswith ( 'YES' ) 
True
```



### 2.4.2 序列对象

list, 一些函数

```python
>>> suits . pop ()              # 删除并返回最后一个元素
'myriad' 
>>> suits . remove ( 'string' )   # 删除第一个等于参数的元素
又增加了三套西装（随着时间的推移，它们的名称和设计不断演变），

>>> suits . append ( 'cup' )               # 在末尾添加一个元素
>>> suits . extend ([ 'sword' ,  'club' ])   # 将序列中的所有元素添加到末尾
```

**判断相等**

`is`和`==`之间的区别。前者检查身份，而后者检查内容的相等性。

```python
>>> a = [1,1]
>>> a is [1,1]
False
>>> a == [1,1]
True

```



**元组**

元组是内置`元组`类型的实例，是一个不可变序列。元组使用元组文字创建，该文字用逗号分隔元素表达式。括号是可选的，但在实践中很常用。任何对象都可以放在元组中。

```python
>>> 1, 2 + 3 
(1, 5) 
>>> ( "the" ,  1 ,  ( "and" ,  "only" )) 
('the', 1, ('and', 'only')) 
>>> type (  ( 10 ,  20 )  ) 
<class 'tuple'>
```

***注意元祖是圆括号，list是方括号***

空元组和单元素元组具有特殊的文字语法。

```python
>>> ()     # 0 个元素
() 
>>> ( 10 ,)  # 1 个元素，这个逗号是不可以省略的，没有逗号就是
(10,)
>>> (10)
10
```

元组虽然不可修改，但是元祖可以包含可修改对象。

```python
>>> b = [1,2]
>>> a = (1,b)
>>> a
(1, [1, 2])
>>> b.append(2)
>>> a
(1, [1, 2, 2])
```



### 2.4.3 字典

初始化

```python
>>> numerals = {'I': 1.0, 'V': 5, 'X': 10}
>>> numerals['I'] = 1
>>> numerals['L'] = 50
>>> numerals
{'I': 1, 'X': 10, 'L': 50, 'V': 5}

>>> dict([(3, 9), (4, 16), (5, 25)])
{3: 9, 4: 16, 5: 25}

>>> {x: x*x for x in range(3,6)}
{3: 9, 4: 16, 5: 25}
```

getOrDefault

```python
>>> numerals.get('A', 0)
0
>>> numerals.get('V', 0)
5
```



### 2.4.4 局部状态

**闭包**
在一个外函数中定义了一个内函数，内函数里运用了外函数的临时变量，并且外函数的返回值是内函数的引用。这样就构成了一个闭包。



**nonlocal**

为了让内函数能修改外函数的变量，需要用nonlocal修饰，否则外函数的变量是只读的



### 2.4.5 局部状态的好处

### 2.4.6 局部状态的弊端

### 2.4.7 利用闭包实现list和dict

### ……

### 总结

2.4 这节介绍了些python的一些语法特性，闭包，局部状态…… ，为后面介绍面向对象编程做了铺垫。

作为非初学者，不太理解这种课程安排。。



## 2.5 面向对象编程

面向对象编程可以将前面提及的所有思想结合在一起。

​	1、数据抽象的思想：在数据的实现和表示之间创建屏障。

​	2、dispatch dictionaries：面对不同的请求表现不同的行为。

​	3、可变数据结构：对象有自己的内部状态，外部无法直接访问。 

面向对象编程提供了相当方便的接口来运用这些思想。

类就像一个有local变量，并且返回函数接口的函数



---

### 2.5.1 对象和类

### 2.5.2 如何定义一个类

Python类需要包含__init__函数，主要用于给实例属性赋初值。

```python
>>> class Account:
        def __init__(self, account_holder):
            self.balance = 0
            self.holder = account_holder

>>> a = Account('Kirk')
>>> a.balance
0
>>> a.holder
'Kirk'
```



调用类的方法

当对一个对象调用方法时，首先查找方法名，发现不是对象成员，而是类中的方法，就将自身作为参数self传给方法。



### 2.5.3 消息传递和点表达式

**method VS function**

在python中，method和function是有概念上的区别的

function的概念包含了method，而method特指对象方法。

```python
>>> type(Account.deposit)
<class 'function'>
>>> type(tom_account.deposit)
<class 'method'>

# function的所有参数都在括号内
>>> Account.deposit(tom_account, 1001) 
1011
# method的第一参数是点表达式的左值，即对象本身self
>>> tom_account.deposit(1007)
2018
```



除了使用点表达式，还可以使用getattr函数获取实例属性，使用hasattr函数判断一个对象实例是否有该属性。

```python
>>> getattr(spock_account, 'balance')
>>> 10
>>> hasattr(spock_account, 'deposit')
>>> True
```



**与类函数不同，对象实例的方法与对象实例绑定在一起。**

```python
>>> type(Account.deposit)
<class 'function'>
>>> type(spock_account.deposit)
<class 'method'>
```

**我们可以用两种方法让对象实例使用方法。**

```python
# The deposit function takes 2 arguments
Account.deposit(spock_account, 1001)  
1011

# The deposit method takes 1 argument
spock_account.deposit(1000)           
2011
```





### 2.5.4 类属性

类属性：被所有对象实例共享的属性，如下所示，interest是类属性。

```python
>>> class Account:
        interest = 0.02            # A class attribute
    def __init__(self, account_holder):
            self.balance = 0
            self.holder = account_holder
        # Additional methods would be defined here
>>> spock_account = Account('Spock')
>>> spock_account.interest
0.02
>>> spock_account.interest = 1 #这会给spock_account对象创建新的interest属性，而不是修改类属性
>>> spock_account.interest
1
>>> Account.interest
0.02
>>> Accound.interest = 0.03
>>> spock_account.interest # 即使修改了类属性，spock_account的interest也不会改变了
1
```

如果对实例对象的类属性进行修改，只会影响该实例对象的该属性，不影响整个类。



### 2.5.5 继承

### 2.5.6 继承的使用

```python
class Fruit:
    def __init__(self, name):
        self.name = name

class Apple(Fruit):
    def __init__(self):
        super().__init__('apple')
```





### 2.5.7 多重继承

python支持一个子类继承多个父类



### 2.5.8 面向对象编程和函数式编程

python同时支持两种编程范式，程序员可以对不同场景选择合适的编程范式。

对于某些模型系统，函数式编程更加适合，例如表示输入和输出的关系





## 2.6 如何通过函数和字典实现类和对象

即使是函数式编程的语言，没有内置实现类和对象，也可以通过函数和字典实现类和对象的功能，包括对象实例、类、基类和继承。

---







## 2.7 对象抽象

**泛型函数，**它可以接受多种不同类型的数据，通常使用**共享接口**、**类型分发**和**类型转换**三种不同的技术来实现。

---

### 2.7.1 对象转换成字符串

为了便于人类理解对象功能，Python规定所有对象都应该能转换成两个不同的字符串表示，

1、str函数返回一个用于人类阅读的字符串

2、repr函数返回一个python表达式，python可将该表达式求值为等价的对象



```python
>>> 12e12 
12000000000000.0 
>>> print(repr(12e12)) 
12000000000000.0 
```



### 2.7.2 Python的特殊方法

Python中定义了一些特殊的方法，用于一些通用的行为。

```python
__init__ 
__str__
__bool__
__repr__
__len__
__getitem__
__call__
__add__
__radd__
```



### 2.7.3 数据的多重表示

用继承实现

有时候一种数据有多种表示方法，有没有什么方法能够让多种方法共存，比如复数的表示，就有直角坐标系表示法和极坐标系表示法。

Python可以使用property装饰器让函数表现出和属性相同的行为。



### 2.7.4 泛型函数

泛型函数支持多种不同类型的参数

实现泛型函数有两种方法

1、类型判断

2、类型转换



## 2.8 算法效率

空间，时间复杂度

---







