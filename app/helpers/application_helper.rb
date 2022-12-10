module ApplicationHelper

  def  capacity_select
   arr = []
   (0..10).each do |num|

     if num == 0
       arr.push(["人数上限無し", 0])
     else
         arr.push([num, num])
     end
   end
   arr
  end
end