def super_print(string, opt = {})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }
  options = defaults.merge(opt)
  
  
    
    string.upcase! if options[:upcase]
    string.reverse! if options[:reverse]
    string * options[:times]

end

p super_print("Hello")                                    #=> "Hello"
p super_print("Hello", :times => 3)                       #=> "Hello" 3x
p super_print("Hello", :upcase => true)                   #=> "HELLO"
p super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"