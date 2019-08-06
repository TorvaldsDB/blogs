# refer to https://www.jianshu.com/p/67433c2b0cb9
# http://hungyuhei.github.io/2013/02/19/metaprogramming-ruby.html
# Object#extend 只是在接收者 eigenclass 中包含模块的快捷方式
class A; end
a = A.new

module M; end

M.send(:define_method, :mtd){ |*| puts "M" }

# M.mtd #=> NoMethodError

A.include M

a.mtd #=> "M"

# If use extend self, module N can call the method mtd
module N
  extend self
end

N.send(:define_method, :mtd){ |*| puts "N" }

N.mtd #=> "N"

A.include N

a.mtd #=> "N"

####################################

# What does extend do is mixin the module into singleton class
# That is why the methods in module can not be the class methods of the class which include the module.
# Module is embedded(mixin) into the singleton_class of the class, so can not be inherited.

module Other
  def three() end
end

class Single
  def Single.four() end
end

a = Single.new

def a.one()
end

class << a
  include Other
  def two()
  end
end

Single.singleton_methods    #=> [:four]
a.singleton_methods(false)  #=> [:two, :one]
a.singleton_methods         #=> [:two, :one, :three]

module M
  def five
  end
end

a.extend M

a.singleton_methods(false) # => [:one, :two] do not include :five
a.singleton_methods        # => [:one, :two, :three, :five] Here is :five
