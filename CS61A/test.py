def partition(n, m):
    if n == m:
        yield str(n)
    if n - m > 0:
        for p in partition(n - m, m):
            yield p + ' + ' + str(m)
    if m > 1:
        yield from partition(n, m - 1)


def fun(n):
    yield n
    if n == 1:
        return
    else:
        fun(n - 1)

class Fruit:
    def __init__(self, name):
        self.name = name

class Apple(Fruit):
    def __init__(self):
        super().__init__('apple')
