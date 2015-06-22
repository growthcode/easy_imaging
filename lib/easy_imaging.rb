require "easy_imaging/version"
require "easy_imaging/engine"
require "mini_magick"

module EasyImaging
  AVAILABLE_METHODS = ["adaptive-blur",  "adaptive-resize",  "adaptive-sharpen",  "adjoin",  "affine",  "alpha",  "annotate",  "antialias",  "append",  "authenticate",  "auto-gamma",  "auto-level",  "auto-orient",  "background",  "bench",  "bias",  "black-threshold",  "blue-primary",  "blue-shift",  "blur",  "border",  "bordercolor",  "brightness-contrast",  "canny",  "caption",  "cdl",  "channel",  "charcoal",  "chop",  "clip",  "clamp",  "clip-mask",  "clip-path",  "clut",  "complexoperator",  "connected-components",  "contrast-stretch",  "coalesce",  "colorize",  "color-matrix",  "colors",  "colorspace",  "combine",  "comment",  "compose",  "composite",  "compress",  "contrast",  "convolve",  "crop",  "cycle",  "decipher",  "debug",  "define",  "deconstruct",  "delay",  "delete",  "density",  "depth",  "despeckle",  "direction",  "display",  "dispose",  "distort",  "distribute-cache",  "dither",  "draw",  "duplicate",  "edge",  "emboss",  "encipher",  "encoding",  "endian",  "enhance",  "equalize",  "evaluate",  "evaluate-sequence",  "extent",  "extract",  "family",  "features",  "fft",  "fill",  "filter",  "flatten",  "flip",  "floodfill",  "flop",  "font",  "format",  "frame",  "function",  "fuzz",  "fx",  "gamma",  "gaussian-blur",  "geometry",  "gravity",  "grayscale",  "green-primary",  "help",  "hough-lines",  "identify",  "ifft",  "implode",  "insert",  "intensity",  "intent",  "interlace",  "interline-spacing",  "interpolate",  "interword-spacing",  "kerning",  "kuwahara",  "label",  "lat",  "layers",  "level",  "limit",  "linear-stretch",  "liquid-rescale",  "log",  "loop",  "mask",  "mattecolor",  "median",  "mean-shift",  "metric",  "mode",  "modulate",  "monitor",  "monochrome",  "morph",  "morphology",  "motion-blur",  "negate",  "noise",  "normalize",  "opaque",  "ordered-dither",  "orient",  "page",  "paint",  "perceptible",  "ping",  "pointsize",  "polaroid",  "poly",  "posterize",  "precision",  "preview",  "print",  "process",  "profile",  "quality",  "quantize",  "quiet",  "radial-blur",  "raise",  "random-threshold",  "red-primary",  "regard-warnings",  "region",  "remap",  "render",  "repage",  "resample",  "resize",  "respect-parentheses",  "roll",  "rotate",  "sample",  "sampling-factor",  "scale",  "scene",  "seed",  "segment",  "selective-blur",  "separate",  "sepia-tone",  "set",  "shade",  "shadow",  "sharpen",  "shave",  "shear",  "sigmoidal-contrast",  "size",  "sketch",  "smush",  "solarize",  "splice",  "spread",  "statistic",  "strip",  "stroke",  "strokewidth",  "stretch",  "style",  "swap",  "swirl",  "synchronize",  "texture",  "threshold",  "thumbnail",  "tile",  "tile-offset",  "tint",  "transform",  "transparent",  "transparent-color",  "transpose",  "transverse",  "treedepth",  "trim",  "type",  "undercolor",  "unique-colors",  "units",  "unsharp",  "verbose",  "version",  "view",  "vignette",  "virtual-pixel",  "wave",  "weight",  "white-point",  "white-threshold", "write"]

  # 'include EasyImaging' will give you this method on your object
    # on the model you include it with.
  # Safe Original: This will process all styles of images except the original.
  AVAILABLE_METHODS.each do |action|
    define_method("#{action}_image") do |*args|
      method_called = action
      paperclip_image.styles.keys.each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  # 'include EasyImaging' will give you this method on your object
    # on the model you include it with.
  # Unsafe Original: processes all styles of images.
  AVAILABLE_METHODS.each do |action|
    define_method("#{action}_image!") do |*args|
      method_called = action
      (paperclip_image.styles.keys + [:original]).each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  def process(style, method_called, *args)
    path = self.paperclip_image.path(style)
    source = MiniMagick::Image.open(path)
    source = source.send(method_called, *args)
    source.write(path)
  end

  module ModuleMethods
    # Use this by 'EasyMagick.rotate_image(@user.image, "-90")'
    # Safe Original: This will process all styles of images except the original.
    AVAILABLE_METHODS.each do |action|
      define_method("#{action}_image") do |attr_image, *args|
        method_called = action
        attr_image.styles.keys.each do |style|
          self.process_image(style, method_called, attr_image, *args)
        end
      end
    end

    # Use this like 'EasyMagick.rotate_image!(@user.image, "-90")'
    # Unsafe Original: processes all styles of images.
    AVAILABLE_METHODS.each do |action|
      define_method("#{action}_image!") do |attr_image, *args|
        styles = attr_image.styles.keys
        method_called = action
        styles.each do |style|
          self.process_image(style, method_called, attr_image, *args)
        end
      end
    end

    def process_image(style, method_called, attr_image, *args)
      path = attr_image.path(style)
      source = MiniMagick::Image.open(path)
      source = source.send(method_called, *args)
      source.write(path)
    end
  end
  extend ModuleMethods
end
