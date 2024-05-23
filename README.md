# lib_gdal

Crystal wrapper for [GDAL](https://gdal.org/). Only a subset of the library is supported for now.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lib_gdal:
       github: crmorello/lib_gdal
   ```

2. Run `shards install`

## Usage

```crystal
require "lib_gdal"
```

You will need [GDAL](https://gdal.org/) installed.

It should work just like the GDAL C api does. Be careful passing pointers around, definitely use Bytes where possible.
```crystal
file_name_cstr = data_path.to_unsafe.as(Pointer(Char))
dataset = LibGDAL.open(file_name_cstr, LibGDAL::Access::ReadOnly)
max_x = LibGDAL.get_raster_x_size(dataset)
max_y = LibGDAL.get_raster_y_size(dataset)
band = LibGDAL.get_raster_band(dataset, 1)
geo_tran = LibC.malloc(6 * sizeof(Float64)).as(Pointer(Float64))
has_no_data_value = uninitialized Int32
no_data_value = LibGDAL.get_no_data_value(@band, pointerof(has_no_data_value)).to_u8! || 0_u8
error = LibGDAL.get_geo_transform(dataset, @geo_tran)
LibGDAL.close(dataset)
LibC.free(geo_tran) if geo_tran
......
buffer = Bytes.new(buffer_size)
LibGDAL.raster_io(band, LibGDAL::RWFlag::Read, 0, 0, x_size, y_size, buffer, x_size, y_size, LibGDAL::DataType::GDT_Byte, 0, 0)
```

## Contributing

1. Fork it (<https://github.com/crmorello/lib_gdal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Corey Morello](https://github.com/crmorello) - creator and maintainer
