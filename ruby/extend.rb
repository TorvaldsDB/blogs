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
