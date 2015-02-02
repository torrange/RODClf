module RODClf

using Images

export img_load,
    integral_sum,
    imgobj_extract,
    test_filter,
    ImageObject,
    FilterShape,
    FilterGeometry

type ImageObject
  properties::Dict
  image::Array
  ndims::Tuple
end

type FilterGeometry
  dx_resolution::Signed #total number of 'dx' units for image
  dy_resolution::Signed #total number of 'dy' units for image
  dx_units::Signed #total 'dx' units needed
  dy_units::Signed #total 'dy' units needed
  x_units::Signed #number of panels on 'x' axis
  y_units::Signed #number of panels on 'y'axis
  x_offset::Signed #offset-coefficient for x-axis
  y_offset::Signed #offset-coefficient for y-axis
end


function img_load(imgpath::String)
  f = imread(imgpath)::Image
  imgobj = ImageObject(f.properties, f.data, size(f.data))::ImageObject
  return imgobj
end

<<<<<<< HEAD

function integral_sum(image_array)
=======
function integral_sum(image_array::Array{Uint8,3})
>>>>>>> 5d0de4ce2e9a96b357aa71cff60d7b2365e7d930
  integral_image = 0x00::Uint8
  for ui in image_array
    integral_image += ui
    continue
  end
  return integral_image
end

######################################
# TEST FUNCTIONS FOR FILTER CREATION #
######################################

function test_filter(imgobj::ImageObject, filter::FilterGeometry)
  properties = imgobj.properties::Dict
  shape = imgobj.ndims::Tuple
  dx = signed(shape[2]/filter.filter_shape.dx_resolution)::Signed
  dy = signed(shape[3]/filter.filter_shape.dy_resolution)::Signed
  imgA = imgobj.image[:,dx:dx*2, dy:dy*8]::Array
  imgB = imgobj.image[:,dx*2:dx*3, dy:dy*8]::Array
  imgA_integral = integral_sum(imgA)::Uint
  imgB_integral = integral_sum(imgB)::Uint
  return properties, imgA_integral, imgB_integral
end


<<<<<<< HEAD
=======

######################################
#                                    #
######################################

# function filter_image(imgobj::ImageObject, filter::FilterGeometry)
#   properties = imgobj.properties::Dict
#   shape = imgobj.ndims::Tuple
#   dx = signed(shape[2]/filter.filter_shape.dx_resolution)::Signed
#   dy = signed(shape[3]/filter.filter_shape.dy_resolution)::Signed
#   imgA = imgobj.image[:,dx:dx*2, dy:dy*8]::Array
#   imgB = imgobj.image[:,dx*2:dx*3, dy:dy*8]::Array
#   imgA_integral = integral_sum(imgA)::Uint
#   imgB_integral = integral_sum(imgB)::Uint
#   return properties, imgA_integral, imgB_integral
# end

>>>>>>> 5d0de4ce2e9a96b357aa71cff60d7b2365e7d930
function imgobj_extract(imgobj::ImageObject)
  shape = imgobj.ndims::Tuple
  properties = imgobj.properties::Dict
  dx, dy = signed(shape[2]/8)::Signed, signed(shape[3]/8)::Signed
  testA = imgobj.image[:,dx:dx*2, dy:dy*8]::Array
  testB = imgobj.image[:,dx*2:dx*3, dy:dy*8]::Array
  return testA, testB
end

<<<<<<< HEAD

=======
# function imgobj_extract(imgobj::ImageObject)
#   shape = imgobj.ndims::Tuple
#   properties = imgobj.properties::Dict
#   dx, dy = signed(shape[2]/8)::Signed, signed(shape[3]/8)::Signed
#   testA = imgobj.image[:,dx:dx*2, dy:dy*8]::Array
#   testB = imgobj.image[:,dx*2:dx*3, dy:dy*8]::Array
#   return testA, testB
# end
>>>>>>> 5d0de4ce2e9a96b357aa71cff60d7b2365e7d930

end
