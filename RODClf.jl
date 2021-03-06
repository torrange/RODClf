module RODClf

using Images

export img_load,
    integral_sum,
    imgobj_extract,
    ImageFilter,
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
  y_units::Signed #number of panels on 'y' axis
  x_units::Signed #number of panels on 'x'axis
  y_offset::Signed #offset-coefficient for y-axis
  x_offset::Signed #offset-coefficient for x-axis
end


function img_load(imgpath::String)
  f = separate(imread(imgpath)::Image)
  imgobj = ImageObject(f.properties, f.data, size(f.data))::ImageObject
  return imgobj
end


function integral_sum(image_array)
  integral_image = 0x00::Uint8
  for ui in image_array
    integral_image += ui
    continue
  end
  return integral_image
end


function ImageFilter(filter_shape::FilterGeometry, imgobj::ImageObject)
    dx_resolution = filter_shape.dx_resolution
    dy_resolution = filter_shape.dy_resolution
    dx_units = filter_shape.dx_units
    dy_units = filter_shape.dy_units
    y_units = filter_shape.x_units
    x_units = filter_shape.y_units
    dx = signed(imgobj.ndims[1]/dx_resolution-0.5)
    dy = signed(imgobj.ndims[2]/dy_resolution-0.5);
    y_offset = filter_shape.y_offset
    x_offset = filter_shape.x_offset

    x = Array[]
    for i in [1:x_units]
        for j in [1:y_units]
            push!(x, imgobj.image[((i+y_offset)*dx)-dx+1:(i+y_offset)*dx,((j+x_offset)*dy)-dy+1:(j+x_offset)*dy,:])
        end
    end
    return x
end


function imgobj_extract(imgobj::ImageObject)
  shape = imgobj.ndims::Tuple
  properties = imgobj.properties::Dict
  dx, dy = signed(shape[2]/8)::Signed, signed(shape[3]/8)::Signed
  testA = imgobj.image[:,dx:dx*2, dy:dy*8]::Array
  testB = imgobj.image[:,dx*2:dx*3, dy:dy*8]::Array
  return testA, testB
end


end
