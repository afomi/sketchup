# HOWTO
# load this file from Sketchup's Ruby Console
#
# load '/path/to/sketchup/skizzup.rb'
class Skizzup
  attr_reader :model,
              :entities,
              :objects

  def initialize
    @model = Sketchup.active_model
    @entities = @model.entities
    @objects = Skizzup::Data

    @scale = 10
  end

  def draw_stairs
    rise = 8
    run = 12
    width = 100

    x1 = 0
    x2 = width
    y1 = run
    y2 = run * 1.1
    z = rise

    p = point(x1, x2, y1, y2, z)

    # Call methods on the Entities collection to draw stuff.
    new_face = @entities.add_face(p)
  end

  def load_page
    model = Sketchup.active_model
    entities = model.active_entities

    point = Geom::Point3d.new 10,20,30
    image = entities.add_image "/Users/ryan/Dropbox/Library/images/_bgs/1712309.jpg", point, 300
    tr1 = Geom::Transformation.rotation(ORIGIN, X_AXIS, 90.degrees)
    image.transform!(tr1)

    point = Geom::Point3d.new 100,20,30
    image = entities.add_image "/Users/ryan/Dropbox/Library/images/_bgs/s5-bg.png", point, 300
    tr1 = Geom::Transformation.rotation(ORIGIN, Y_AXIS, 90.degrees)
    image.transform!(tr1)

    point = Geom::Point3d.new 100,20,30
    image = entities.add_image "/Users/ryan/Dropbox/Library/images/_bgs/R_medium-01-592x700.png", point, 300
    tr1 = Geom::Transformation.rotation(ORIGIN, Z_AXIS, 90.degrees)
    image.transform!(tr1)

    if (image)
      UI.messagebox image
    else
      UI.messagebox "Failure"
    end
  end

  # dir = /Users/ryan/Dropbox/Development/rails/unit-works/screenshots
  def load_images_in_directory(dir = '')
    x = 0
    y = 0
    z = 0

    Dir.entries(dir).each_with_index do |f, i|
      next unless f.match(".png")
      puts f
      x = 350 * i # stagger the images across the x-axis
      point = Geom::Point3d.new(x,y,z)
      image = @entities.add_image "#{dir}#{f}", point, 300
      transform = Geom::Transformation.rotation(ORIGIN, X_AXIS, 90.degrees)
      image.transform!(transform)

      if (image)
        puts 'image loaded successfully'
        # UI.messagebox image
      else
        UI.messagebox "Failure"
      end
    end
  end

  def prompt
    prompts = ["What is your Name?", "What is your Age?", "Gender"]
    defaults = ["Enter name", "", "Male"]
    list = ["", "", "Male|Female"]
    input = UI.inputbox prompts, defaults, list, "Tell me about yourself."
  end

  # :alias point2d
  def point(x1, x2, y1, y2, z = 0)
    # Create a series of "points", each a 3-item array containing x, y, and z.
    pt1 = [x1, y1, z]
    pt2 = [x2, y1, z]
    pt3 = [x2, y2, z]
    pt4 = [x1, y2, z]

    return [pt1, pt2, pt3, pt4]
  end

  def prompt_draw_sphere
    prompts = ["Radius"]
    defaults = ["2"]
    list = [""]
    input = UI.inputbox prompts, defaults, list, "Create a Circle"

    draw_sphere(input.first.to_i)
  end

  def draw_text(string = "This is a Test", point = nil)
    @entities.add_text(string, point)
  end

  def draw_sphere(radius = 2, point = [0,0,0])
    e = @entities
    c1 = e.add_circle(point, [0,0,1], radius.to_i.feet, 24)
    c2 = e.add_circle([10.feet,0,0], [1,0,0], radius.to_i.feet, 24)
    f = e.add_face(c1)
    f.material = "red"

    status = f.followme(c2)
    status = c2.each {|edge| edge.erase!}
  end

  def draw_point(point)
    draw_sphere('1in', point)
  end

  # draw the objects on the screen
  def load_objects
    @objects.each do |obj|
      case obj[:type]
      when :sphere
        draw_sphere(obj[:radius], obj[:point])
      when :text
        draw_text(obj[:text], obj[:point])
      when :point
        draw_point(obj[:point])
      end
    end
  end

  def draw_elements
    elements.each do |element|
      # draw a box for each element
      # pick a basic place
      # handle its depth
    end
  end

  def elements
    [
      # name, depth
      ['browser', 1],

      # Browser Features
      ['url bar', 2],
      ['bookmarks', 2],

      ['page', 3],

      # Page Feature
      ['components', 4],
      ['elements', 4],
      ['div', 4],
      ['p', 4],
      ['h1', 4],
      ['h2', 4],
      ['h3', 4],
      ['h4', 4],
      ['h5', 4],
      ['h6', 4],
      ['h7', 4],
      ['span', 4],
      ['a', 4],
      ['form', 4],
      ['section', 4],
      ['aside', 4],
      ['header', 4],
      ['footer', 4]
    ]
  end

end
