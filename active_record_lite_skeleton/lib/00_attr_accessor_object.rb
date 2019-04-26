class AttrAccessorObject

  def self.my_attr_accessor(*names)
    names.each do |n|
      define_method(n.to_s) do 
        self.instance_variable_get("@#{n}")
      end
      define_method("#{n}=") do |new_n|
        self.instance_variable_set("@#{n}", new_n)
      end
    end
  end

end
