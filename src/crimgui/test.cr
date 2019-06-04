require "./lib"

my_rect = LibImGui.customrect_allocate

puts my_rect.value.width
puts my_rect.value.height

my_rect.value.width = 100
my_rect.value.height = 10

puts my_rect.value.width
puts my_rect.value.height

LibImGui.customrect_destroy(my_rect)
puts LibImGui.customrect_is_packed(my_rect)

puts my_rect.value.id
puts my_rect.value.width
puts my_rect.value.height
