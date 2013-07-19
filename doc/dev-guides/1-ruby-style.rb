# encoding: utf-8

# Ruby 代码风格指南

# 参考资源:
# https://github.com/styleguide/ruby
# http://ruby-china.org/wiki/coding-style
# https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md

# 1. 缩进: 使用两个空格, 不使用 Tab

# 2. 每行不超过 79 个字符. 对于过长的方法调用, 使用下面的格式
def send_mail(source)
  Mailer.deliver(to: 'bob@example.com',
                 from: 'us@example.com',
                 subject: 'Important message',
                 body: source.text)
end
# 或
def send_mail(source)
  Mailer.deliver(
    to: 'bob@example.com',
    from: 'us@example.com',
    subject: 'Important message',
    body: source.text)
end

# 3. 避免不必要的行尾空白符

# 4. 在逗号，分号，冒号，运算符号的左右使用一个空格
sum = 1 + 2
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'

e = M * c**2 # ** 运算符可以例外

[1, 2, 3].each { |e| puts e } # block 的参数和管道符之间不要加空格

def some_method(arg1 = :default, arg2 = nil, arg3 = [])
end

# 5. (, [ 的后面，或 ], ) 的前面不要空格
some(arg).other
[1, 2, 3].length

# 6. Hash 的花括号和内容之间不要加空格; block 的花括号和内容之间使用一个空格
hash = {a: 1, 'b' => 2}
[1, 2, 3].each { |e| puts e }
[1, 2, 3].each{ |e| puts e }.map(&:to_s)

# 7. 单行的 block 使用花括号, 多行的 block 使用 do...end
[1, 2, 3].each { |e| puts e }

[1, 2, 3].each do |e|
  puts e
  e * 2
end

# 8. 不要使用 and 和 or, 使用 && 和 ||.

# 9. 方法及变量名使用诸如 snake_case 的形式, 类及模块名使用诸如 CamelCase 的形式,
# 常量名使用诸如 SCREAMING_SNAKE_CASE 的形式.

# 10. 方法之间使用一个空行. 相对独立的逻辑代码之间建议也使用一个空行.

# 11. 字符串字面量优先使用单引号.
puts 'Hello World!'
puts "Hello #{name}!" # 注意: #{} 中的花括号永远不要省略

# 12. 尽量避免一个方法内容超过10行代码(不算空行); 尽量避免方法的参数超过三个.

# 13. 代码中的注释使用 YARD 推荐的的格式.
# 参考: http://rubydoc.info/docs/yard/file/docs/Tags.md#Tag_List
