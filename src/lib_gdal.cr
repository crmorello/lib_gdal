@[Link(ldflags: "`gdal-config --libs`")]
lib LibGDAL
  fun all_register = GDALAllRegister : Void
  alias GDALDriverH = Void*
  fun get_driver_by_name = GDALGetDriverByName(name : UInt8*) : GDALDriverH

  alias CSLConstList = Char**
  fun create = GDALCreate(driver : GDALDriverH, filename : UInt8*, width : LibC::Int, height : LibC::Int, bands : LibC::Int, type : DataType, options : CSLConstList) : GDALDatasetH
  alias GDALProgressFunc = Pointer((Int32, Float64, LibC::Char*, Void*) -> Void)
  fun create_copy = GDALCreateCopy(driver : GDALDriverH, filename : UInt8*, dataset : GDALDatasetH, size : LibC::Int, options : CSLConstList, progress_func : GDALProgressFunc, pProgressData : Void*) : GDALDatasetH
  enum Access
    ReadOnly = 0
    Update   = 1
  end

  alias GDALDatasetH = Void*
  fun open = GDALOpen(filename : Char*, access : Access) : GDALDatasetH

  enum CPLErr
    CE_None    = 0
    CE_Debug   = 1
    CE_Warning = 2
    CE_Failure = 3
    CE_Fatal   = 4
  end

  fun close = GDALClose(dataset : GDALDatasetH) : CPLErr

  fun get_raster_count = GDALGetRasterCount(dataset : GDALDatasetH) : LibC::Int

  alias GDALRasterBandH = Void*
  fun get_raster_band = GDALGetRasterBand(dataset : GDALDatasetH, band : LibC::Int) : GDALRasterBandH
  fun get_raster_x_size = GDALGetRasterXSize(dataset : GDALDatasetH) : LibC::Int
  fun get_raster_y_size = GDALGetRasterYSize(dataset : GDALDatasetH) : LibC::Int
  fun get_no_data_value = GDALGetRasterNoDataValue(raster_band : GDALRasterBandH, err : LibC::Int*) : LibC::Double
  enum DataType
    GDT_Unknown
    GDT_Byte
    GDT_Int8
    GDT_UInt16
    GDT_Int16
    GDT_UInt32
    GDT_Int32
    GDT_UInt64
    GDT_Int64
    GDT_Float32
    GDT_Float64
    GDT_CInt16
    GDT_CInt32
    GDT_CFloat32
    GDT_CFloat64
    GDT_TypeCount
  end
  fun get_raster_data_type = GDALGetRasterDataType(dataset : GDALDatasetH) : DataType

  alias GDALColorTableH = Void*
  fun get_raster_color_table = GDALGetRasterColorTable(raster_band : GDALRasterBandH) : GDALColorTableH

  fun get_projection_ref = GDALGetProjectionRef(dataset : GDALDatasetH) : Char*
  enum RWFlag
    Read  = 0
    Write = 1
  end
  alias Err = Int32
  fun raster_io = GDALRasterIO(
    hRBand : GDALRasterBandH,
    eRWFlag : RWFlag,
    nDSXOff : Int32,
    nDSYOff : Int32,
    nDSXSize : Int32,
    nDSYSize : Int32,
    pBuffer : Void*,
    nBXSize : Int32,
    nBYSize : Int32,
    eBDataType : DataType,
    nPixelSpace : Int32,
    nLineSpace : Int32
  ) : Err

  fun get_geo_transform = GDALGetGeoTransform(dataset : GDALDatasetH, padfGeoTransform : Pointer(Float64)) : CPLErr

  enum GDALResampleAlg
    NearestNeighbor
    Bilinear
    Cubic
    CubicSpline
    Lanczos
    Average
    Mode
    Max
    Min
    Med
    Q1
    Q3
  end

  alias GDALWarpOptions = Char**
  fun reproject_image = GDALReprojectImage(src_dataset : GDALDatasetH, psz_src_wkt : Char*, dst_dataset : GDALDatasetH, psz_dst_wkt : Char*, resample_alg : GDALResampleAlg, warp_mem_limit : LibC::Double, max_error : LibC::Double, progress_func : GDALProgressFunc, progressArg : Void*, options : GDALWarpOptions) : CPLErr

  alias VSILFILE = Void*
  fun vsif_open = VSIFOpenL(file_name : UInt8*, access : UInt8*) : VSILFILE
  enum VSIFSeek
    Set
    Cur
    End
  end

  fun vsif_seek = VSIFSeekL(file : VSILFILE, offset : UInt8, whence : VSIFSeek) : LibC::Int
  fun vsif_tell = VSIFTellL(file : VSILFILE) : LibC::UInt64T
  fun vsif_read = VSIFReadL(buffer : Void*, size : LibC::SizeT, count : LibC::SizeT, file : VSILFILE) : LibC::SizeT
  fun vsif_close = VSIFCloseL(file : VSILFILE) : LibC::Int
  fun vsif_unlink = VSIUnlink(file_name : UInt8*) : LibC::Int
  end
