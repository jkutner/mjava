class Array
  def compact
    select{|x| !x.nil? }
  end

  def delete_if(&block)
    to_del = []
    each do |v|
      to_del << v if yield(v)
    end
    to_del.each do |v|
      delete(v)
    end
  end
end
