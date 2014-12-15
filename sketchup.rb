# Sample Usage of Skizzup

load '/sketchup/skizzup.rb'

s = Skizzup.new

# Example 1

# s.draw_stairs # draws 1 stair

s.load_page
          # starting X
          #   starting Y
          #      ending X
          #         ending Y
          #             Z
z = s.point(0,10,50,100,11)
s.entities.add_face(z)

(1..50).each do |i|
  z = s.point(0,10,50,rand(100),i)
  s.entities.add_face(z)
end

(1..50).each do |i|
  x = rand(10)
  z = s.point(x,10,x + 50,100,i)
  s.entities.add_face(z)
end

(1..50).each do |i|
  x = rand(10)
  z = s.point(x,x+10,50,100,i)
  s.entities.add_face(z)
end


hash = {}
s.elements.each do |element|
  name = element[0]
  height = 36        # X
  width = 36         # Y
  depth = element[1] # Z

  # count things per each depth
  iteration = hash[depth.to_s] = hash[depth.to_s].to_i + 1

  # amount of space per iteration on the same depth
  x_run = 0
  y_run = 10

  x1 = 0 + x_run
  x2 = width
  y1 = 0 + (iteration * height) + y_run
  y2 = height + (iteration * height)

                # x1,x2,y1,y2,z
  point = s.point(x1, x2, y1, y2, depth)
  s.entities.add_face(point)
end

hash = {}
(1..20).each do |i|
  x = 0
  y = 0
  width = 36

  x2 = x + width
  y2 = y + width

  c = hash[i.to_s] = hash[i.to_s].to_i + 1
  z = s.point(x, x2, y, y2, i)
  s.entities.add_face(z)
end

## Docs
