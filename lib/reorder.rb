class Array
  #reorders an array
  #
  # simple example
  #   arr1 = [0,1,2,3,4]
  #   arr2 = [3,2,4,1, 0]
  #   arr1.reorder(arr2) = [3,2,4,1,0]
  #
  # active record example
  # idarr = [4,2,10,8]
  # users = User.find(idarr)
  # users.reorder(idarr, "id").collect {|u| u.id} = [4,2,10,8]
  #
  # obj_key needs to return a int
  def reorder(array_of_ordered_values, obj_key = "")
    if obj_key.blank? #just collect by position
      return array_of_ordered_values.collect {|a| self[a]}
    else
      h = {}
      self.each do |obj|
        h[obj.send(obj_key)] = obj
      end
      return array_of_ordered_values.collect {|a| h[a]}
    end
  end
end 